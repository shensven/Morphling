import SwiftUI

struct ColorPickerView: View {
    @Environment(Storage.self) var storage
    @Environment(ColorConvert.self) var colorConvert

    var body: some View {
        @Bindable var storage = storage
        @Bindable var colorConvert = colorConvert

        VStack(spacing: 2) {
            HStack(spacing: Self.spacing) {
                swatch

                switch storage.currentColorFormat {
                case .hex:
                    HStack(spacing: 4) {
                        Text(verbatim: "#")
                            .foregroundStyle(.secondary)
                        TextField(text: $colorConvert.hex) { EmptyView() }
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: colorConvert.hex) { _, newValue in
                                // Keep up to six hex digits, so a pasted "#FF0000" still works
                                let digits = String(newValue.filter(\.isHexDigit).prefix(6))
                                if digits != newValue {
                                    colorConvert.hex = digits
                                } else {
                                    colorConvert.convert(from: .hex)
                                }
                            }
                    }
                case .rgb:
                    ChannelField(value: $colorConvert.red, range: 0...255) { colorConvert.convert(from: .rgb) }
                    ChannelField(value: $colorConvert.green, range: 0...255) { colorConvert.convert(from: .rgb) }
                    ChannelField(value: $colorConvert.blue, range: 0...255) { colorConvert.convert(from: .rgb) }
                case .hsl:
                    ChannelField(value: $colorConvert.hue, range: 0...360, unit: "deg") {
                        colorConvert.convert(from: .hsl)
                    }
                    ChannelField(value: $colorConvert.saturation, range: 0...100, unit: "%") {
                        colorConvert.convert(from: .hsl)
                    }
                    ChannelField(value: $colorConvert.lightness, range: 0...100, unit: "%") {
                        colorConvert.convert(from: .hsl)
                    }
                }

                Picker(selection: $storage.currentColorFormat, label: EmptyView()) {
                    ForEach(ColorFormat.allCases, id: \.self) { item in
                        Text(item.rawValue).tag(item)
                    }
                }
                .frame(width: Self.pickerWidth)
            }

            // Captions line up under the fields: same spacing, same fixed-width ends
            HStack(spacing: Self.spacing) {
                Color.clear.frame(width: Self.swatchSize, height: 0)
                ForEach(storage.currentColorFormat.captions, id: \.self) { caption in
                    Text(verbatim: caption)
                        .font(.footnote)
                        .foregroundStyle(.primary.opacity(0.7))
                        .frame(maxWidth: .infinity)
                }
                Color.clear.frame(width: Self.pickerWidth, height: 0)
            }
        }
    }

    private static let spacing: CGFloat = 8
    private static let swatchSize: CGFloat = 18
    private static let pickerWidth: CGFloat = 72

    private var swatch: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
            Color(
                .sRGB,
                red: colorConvert.red / 255,
                green: colorConvert.green / 255,
                blue: colorConvert.blue / 255
            )
            .clipShape(.rect(cornerRadius: 4))
        }
        .frame(width: Self.swatchSize, height: Self.swatchSize)
    }
}

private extension ColorFormat {
    /// Labels shown under each input field.
    var captions: [String] {
        switch self {
        case .hex: ["hex"]
        case .rgb: ["r", "g", "b"]
        case .hsl: ["h", "s", "l"]
        }
    }
}

/// A numeric field for one color channel. Out-of-range input is clamped, otherwise `onChange` runs.
private struct ChannelField: View {
    @Binding var value: CGFloat
    let range: ClosedRange<CGFloat>
    var unit: String?
    let onChange: () -> Void

    var body: some View {
        TextField(value: $value, format: FloatingPointFormatStyle<CGFloat>().precision(.fractionLength(0))) {
            EmptyView()
        }
            .textFieldStyle(.roundedBorder)
            .overlay(alignment: .trailing) {
                if let unit {
                    Text(verbatim: unit)
                        .font(.footnote)
                        .foregroundStyle(.primary.opacity(0.5))
                        .padding(.trailing, 4)
                        .allowsHitTesting(false)
                }
            }
            .onChange(of: value) { _, newValue in
                let clamped = min(max(newValue, range.lowerBound), range.upperBound)
                if clamped != newValue {
                    value = clamped
                } else {
                    onChange()
                }
            }
    }
}

#Preview {
    ColorPickerView()
        .environment(Storage())
        .environment(ColorConvert())
}
