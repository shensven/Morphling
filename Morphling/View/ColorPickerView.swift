import SwiftUI

enum RGB: String, CaseIterable {
    case componentR = "r"
    case componentG = "g"
    case componentB = "b"
}

enum HSL: String, CaseIterable {
    case componentH = "h"
    case componentS = "s"
    case componentL = "l"
}

enum ColorFormat: String, CaseIterable {
    case hex = "Hex"
    case rgb = "RGB"
    case hsl = "HSL"
}

struct ColorPickerView: View {
    @AppStorage("currentColorFormat") var currentColorFormat: ColorFormat = .hex
    @EnvironmentObject var userDefaults: UserDefaults

    var body: some View {
        HStack {
            if currentColorFormat == .hex {
                VStack(spacing: 2) {
                    HStack(spacing: 2) {
                        Text("#")
                            .font(.body)
                            .foregroundColor(.primary.opacity(0.7))
                        TextField("", text: $userDefaults.hex)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: userDefaults.hex) { target in
                                if target.count > 6 {
                                    userDefaults.hex = "FFFFFF"
                                }
                                if target.count == 6 {
                                    let newRgb8 = userDefaults.hexToRgb8(hex: target)
                                    let newHsl = userDefaults.rgb8ToHsl(rgb8: newRgb8)
                                    userDefaults.rgb8 = newRgb8
                                    userDefaults.hsl = newHsl
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
                            value: $userDefaults.rgb8[RGB.allCases.firstIndex(of: item)!],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: userDefaults.rgb8) { conponent in
                            if conponent[RGB.allCases.firstIndex(of: item)!] > 255 {
                                userDefaults.rgb8[RGB.allCases.firstIndex(of: item)!] = 255
                            }
                            if conponent[RGB.allCases.firstIndex(of: item)!] < 0 {
                                userDefaults.rgb8[RGB.allCases.firstIndex(of: item)!] = 0
                            }

                            let newRgb8 = [conponent[0], conponent[1], conponent[2]]

                            let newHex = userDefaults.rgb8ToHex(rgb8: newRgb8)
                            let newHsl = userDefaults.rgb8ToHsl(rgb8: newRgb8)

                            userDefaults.hex = newHex
                            userDefaults.hsl = newHsl
                        }
                        Text(item.rawValue.uppercased())
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                            .tag(item)
                    }
                }
            }

            if currentColorFormat == .hsl {
                ForEach(HSL.allCases, id: \.self) { item in
                    VStack(spacing: 2) {
                        TextField(
                            "",
                            value: $userDefaults.hsl[HSL.allCases.firstIndex(of: item)!],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: userDefaults.rgb8) { conponent in
                            if conponent[0] > 360 {
                                userDefaults.hsl[0] = 360
                            }
                            if conponent[0] < 0 {
                                userDefaults.hsl[0] = 0
                            }
                            if conponent[1] > 100 {
                                userDefaults.hsl[1] = 100
                            }
                            if conponent[1] < 0 {
                                userDefaults.hsl[1] = 0
                            }
                            if conponent[2] > 100 {
                                userDefaults.hsl[2] = 100
                            }
                            if conponent[2] < 0 {
                                userDefaults.hsl[2] = 0
                            }

                            let componentH = conponent[0]
                            let componentS = conponent[1]
                            let componentL = conponent[2]

                            let newHsl = [componentH, componentS, componentL]

                            let newRgb8 = userDefaults.hslToRgb8(hsl: newHsl)
                            let newHex = userDefaults.rgb8ToHex(rgb8: newRgb8)

                            userDefaults.rgb8 = newRgb8
                            userDefaults.hex = newHex
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
