import SwiftUI

struct OptionView: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var colorConvert: ColorConvert

    var body: some View {
        HStack {
            Toggle(isOn: $storage.isPrefixWithFilter) {
                HStack(spacing: 2) {
                    Text("Main.Prefix_with")
                    Text("filter:")
                        .font(.body)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                        .foregroundColor(.primary)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(3)
                }
            }
            Spacer()
            Button("Main.Re-convert") {
                switch storage.currentColorFormat {
                case .hex:
                    colorConvert.hexToAny(hex: colorConvert.hex)
                case .rgb:
                    colorConvert.rgbToAny(rgb: [colorConvert.red, colorConvert.green, colorConvert.blue])
                case .hsl:
                    colorConvert.hslToAny(hsl: [colorConvert.hue, colorConvert.saturation, colorConvert.lightness])
                }
            }
            Button("Main.Clear") {
                colorConvert.conventedContent = nil
            }
        }
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
    }
}
