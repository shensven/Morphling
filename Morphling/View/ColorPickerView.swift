import SwiftUI

struct ColorPickerView: View {
    @Environment(AppSettings.self) var settings
    @Environment(ColorConverter.self) var converter

    var body: some View {
        @Bindable var settings = settings
        @Bindable var converter = converter

        VStack(spacing: 2) {
            HStack(spacing: Self.spacing) {
                swatch

                switch settings.currentColorFormat {
                case .hex:
                    HStack(spacing: 4) {
                        Text(verbatim: "#")
                            .foregroundStyle(.secondary)
                        TextField(text: $converter.hex) { EmptyView() }
                            .textFieldStyle(.roundedBorder)
                            .onChange(of: converter.hex) { _, newValue in
                                // Keep up to six hex digits, so a pasted "#FF0000" still works
                                let digits = String(newValue.filter(\.isHexDigit).prefix(6))
                                if digits != newValue {
                                    converter.hex = digits
                                } else {
                                    converter.convert(from: .hex)
                                }
                            }
                    }
                case .rgb:
                    ChannelField(value: $converter.red, range: 0...255) { converter.convert(from: .rgb) }
                    ChannelField(value: $converter.green, range: 0...255) { converter.convert(from: .rgb) }
                    ChannelField(value: $converter.blue, range: 0...255) { converter.convert(from: .rgb) }
                case .hsl:
                    ChannelField(value: $converter.hue, range: 0...360, unit: "deg") {
                        converter.convert(from: .hsl)
                    }
                    ChannelField(value: $converter.saturation, range: 0...100, unit: "%") {
                        converter.convert(from: .hsl)
                    }
                    ChannelField(value: $converter.lightness, range: 0...100, unit: "%") {
                        converter.convert(from: .hsl)
                    }
                }

                Picker(selection: $settings.currentColorFormat, label: EmptyView()) {
                    ForEach(ColorFormat.allCases, id: \.self) { item in
                        Text(item.rawValue).tag(item)
                    }
                }
                .frame(width: Self.pickerWidth)
            }

            // Captions line up under the fields: same spacing, same fixed-width ends
            HStack(spacing: Self.spacing) {
                Color.clear.frame(width: Self.swatchSize, height: 0)
                ForEach(settings.currentColorFormat.captions, id: \.self) { caption in
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
                red: converter.red / 255,
                green: converter.green / 255,
                blue: converter.blue / 255
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
        .environment(AppSettings())
        .environment(ColorConverter())
}
