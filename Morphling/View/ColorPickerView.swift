import SwiftUI

enum RGB: String, CaseIterable {
    case r, g, b
}

enum ColorFormat: String, CaseIterable {
    case hex = "Hex"
    case rgb = "RGB"
}

struct ColorPickerView: View {
    @AppStorage("currentColorFormat") var currentColorFormat: ColorFormat = .hex

    @State private var hexColor: String = "000000"
    @State private var rgbColor: [CGFloat] = [0.0, 0.0, 0.0]

    var body: some View {
        HStack {
            if currentColorFormat == .hex {
                VStack(spacing: 2) {
                    HStack(spacing: 2) {
                        Text("#")
                            .font(.body)
                            .foregroundColor(.primary.opacity(0.7))
                        TextField("", text: $hexColor)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: hexColor) { value in
                                if value.count > 6 {
                                    self.hexColor = "FFFFFF"
                                }
                                let hex = hexColor
                                if hex.count == 6 {
                                    let scanner = Scanner(string: hex)
                                    var newRgbColor: UInt64 = 0
                                    scanner.scanHexInt64(&newRgbColor)
                                    self.rgbColor = [
                                        CGFloat((newRgbColor & 0xFF0000) >> 16),
                                        CGFloat((newRgbColor & 0x00FF00) >> 8),
                                        CGFloat(newRgbColor & 0x0000FF)
                                    ]
                                }
                            }
                    }
                    Text("Hex color")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0))
                }
            }

            if currentColorFormat == .rgb {
                ForEach(RGB.allCases, id: \.self) { item in
                    VStack(spacing: 2) {
                        TextField(
                            "",
                            value: $rgbColor[RGB.allCases.firstIndex(of: item)!],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: rgbColor) { conponent in
                            if conponent[RGB.allCases.firstIndex(of: item)!] > 255 {
                                rgbColor[RGB.allCases.firstIndex(of: item)!] = 255
                            }
                            if conponent[RGB.allCases.firstIndex(of: item)!] < 0 {
                                rgbColor[RGB.allCases.firstIndex(of: item)!] = 0
                            }
                            let r = rgbColor[0]
                            let g = rgbColor[1]
                            let b = rgbColor[2]
                            let newHexColor = String(format: "%02X%02X%02X", Int(r), Int(g), Int(b))
                            self.hexColor = newHexColor
                        }
                        Text(item.rawValue.uppercased())
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                            .tag(item)
                    }
                }
            }

            VStack(spacing: 2) {
                Picker("", selection: $currentColorFormat) {
                    ForEach(ColorFormat.allCases, id: \.self) { item in
                        Text(item.rawValue).tag(item)
                    }
                }.frame(width: 80)
                Text("format")
                    .font(.footnote)
                    .foregroundColor(.primary.opacity(0))
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
