import Testing
@testable import Morphling

// These tests run converter.js from the host app's bundle, so they also catch a stale or broken build of it
@MainActor
struct ColorConverterTests {
    @Test func hexFillsTheOtherFormatsAndTheFilter() {
        let converter = ColorConverter()
        converter.hex = "FF0000"
        converter.convert(from: .hex)

        #expect([converter.red, converter.green, converter.blue] == [255, 0, 0])
        #expect([converter.hue, converter.saturation, converter.lightness] == [0, 100, 50])
        #expect(isFilter(converter.filter))
    }

    @Test func rgbFillsTheOtherFormatsAndTheFilter() {
        let converter = ColorConverter()
        (converter.red, converter.green, converter.blue) = (0, 128, 255)
        converter.convert(from: .rgb)

        #expect(converter.hex == "0080FF")
        #expect([converter.hue, converter.saturation, converter.lightness].map { $0.rounded() } == [210, 100, 50])
        #expect(isFilter(converter.filter))
    }

    @Test func hslFillsTheOtherFormatsAndTheFilter() {
        let converter = ColorConverter()
        (converter.hue, converter.saturation, converter.lightness) = (120, 100, 25)
        converter.convert(from: .hsl)

        #expect(converter.hex == "008000")
        #expect([converter.red, converter.green, converter.blue].map { $0.rounded() } == [0, 128, 0])
        #expect(isFilter(converter.filter))
    }

    @Test(arguments: ["", "FF00", "GG0000"])
    func incompleteHexClearsTheFilter(hex: String) {
        let converter = ColorConverter()
        converter.convert(from: .hex)
        #expect(converter.filter != nil)

        converter.hex = hex
        converter.convert(from: .hex)
        #expect(converter.filter == nil)
    }

    @Test func outputAddsThePrefixOnlyWhenAsked() {
        let converter = ColorConverter()
        #expect(converter.output(withFilterPrefix: true) == nil)

        converter.filter = "invert(50%)"
        #expect(converter.output(withFilterPrefix: false) == "invert(50%)")
        #expect(converter.output(withFilterPrefix: true) == "filter: invert(50%)")
    }

    /// The filter solver is randomized, so check the shape of the result rather than its values.
    private func isFilter(_ filter: String?) -> Bool {
        guard let filter else { return false }
        return filter.hasPrefix("brightness(0) saturate(100%) invert(")
            && filter.contains("hue-rotate(")
            && filter.hasSuffix("%)")
    }
}
