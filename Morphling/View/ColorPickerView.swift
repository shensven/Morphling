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

    var unit: String {
        switch self {
        case .componentH:
            return "deg"
        case .componentS:
            return "%"
        case .componentL:
            return "%"
        }
    }
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
                    ZStack(alignment: .leading) {
                        TextField("", text: $userDefaults.hex)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: userDefaults.hex) { target in
                                if target.count > 6 {
                                    userDefaults.hex = "FFFFFF"
                                }
                                userDefaults.hexToAny(hex: target)
                            }
                        Text("#")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.5))
                            .padding(.leading, 4)
                    }
                    Text("Hex")
                        .font(.footnote)
                        .hidden()
                }
            }

            if currentColorFormat == .rgb {
                ForEach(RGB.allCases, id: \.self) { component in
                    VStack(spacing: 2) {
                        TextField(
                            "",
                            value: $userDefaults.rgb["\(component.rawValue)"],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: userDefaults.rgb) { target in
                            if target[component.rawValue]! > 255 {
                                userDefaults.rgb[component.rawValue] = 255
                            }
                            if target[component.rawValue]! < 0 {
                                userDefaults.rgb[component.rawValue] = 0
                            }

                            userDefaults.rgbToAny(rgb: [
                                "r": target["r"] ?? 0,
                                "g": target["g"] ?? 0,
                                "b": target["b"] ?? 0
                            ])
                        }
                        Text(component.rawValue.uppercased())
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                            .tag(component)
                    }
                }
            }

            if currentColorFormat == .hsl {
                ForEach(HSL.allCases, id: \.self) { component in
                    VStack(spacing: 2) {
                        ZStack(alignment: .trailing) {
                            TextField(
                                "",
                                value: $userDefaults.hsl["\(component.rawValue)"],
                                formatter: NumberFormatter()
                            )
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: userDefaults.hsl) { hsl in
                                if hsl["h"]! > 360 {
                                    userDefaults.hsl["h"] = 360
                                }
                                if hsl["h"]! < 0 {
                                    userDefaults.hsl["h"] = 0
                                }
                                if hsl["s"]! > 100 {
                                    userDefaults.hsl["s"] = 100
                                }
                                if hsl["s"]! < 0 {
                                    userDefaults.hsl["s"] = 0
                                }
                                if hsl["l"]! > 100 {
                                    userDefaults.hsl["l"] = 100
                                }
                                if hsl["l"]! < 0 {
                                    userDefaults.hsl["l"] = 0
                                }

                                userDefaults.hslToAny(hsl: [
                                    "h": hsl["h"]!,
                                    "s": hsl["s"]!,
                                    "l": hsl["l"]!
                                ])
                            }
                            Text(component.unit)
                                .font(.footnote)
                                .foregroundColor(.primary.opacity(0.5))
                                .padding(.trailing, 4)
                        }
                        Text(component.rawValue.uppercased())
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.7))
                            .tag(component)
                    }
                }
            }

            VStack(spacing: 2) {
                Picker(selection: $currentColorFormat, label: EmptyView()) {
                    ForEach(ColorFormat.allCases, id: \.self) { item in
                        Text(item.rawValue).tag(item)
                    }
                }.frame(width: 72)
                Text("format")
                    .font(.footnote)
                    .hidden()
            }
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}
