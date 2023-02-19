import SwiftUI

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
            VStack(spacing: 2) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1)
                    Color(
                        .sRGB,
                        red: userDefaults.red / 255,
                        green: userDefaults.green / 255,
                        blue: userDefaults.blue / 255
                    ).clipShape(RoundedRectangle(cornerRadius: 4))
                }.frame(width: 18, height: 18)

                Text("p")
                    .font(.footnote)
                    .hidden()
            }

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
                VStack(spacing: 2) {
                    TextField(
                        "",
                        value: $userDefaults.red,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: userDefaults.red) { target in
                        if target > 255 {
                            userDefaults.red = 255
                        } else if target < 0 {
                            userDefaults.red = 0
                        } else {
                            userDefaults.rgbToAny(rgb: [target, userDefaults.green, userDefaults.blue])
                        }
                    }
                    Text("r")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
                VStack(spacing: 2) {
                    TextField(
                        "",
                        value: $userDefaults.green,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: userDefaults.green) { target in
                        if target > 255 {
                            userDefaults.green = 255
                        } else if target < 0 {
                            userDefaults.green = 0
                        } else {
                            userDefaults.rgbToAny(rgb: [userDefaults.red, target, userDefaults.blue])
                        }
                    }
                    Text("g")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
                VStack(spacing: 2) {
                    TextField(
                        "",
                        value: $userDefaults.blue,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: userDefaults.blue) { target in
                        if target > 255 {
                            userDefaults.blue = 255
                        } else if target < 0 {
                            userDefaults.blue = 0
                        } else {
                            userDefaults.rgbToAny(rgb: [userDefaults.red, userDefaults.green, target])
                        }
                    }
                    Text("b")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
            }

            if currentColorFormat == .hsl {
                VStack(spacing: 2) {
                    ZStack(alignment: .trailing) {
                        TextField(
                            "",
                            value: $userDefaults.hue,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: userDefaults.hue) { target in
                            if target > 360 {
                                userDefaults.hue = 360
                            } else if target < 0 {
                                userDefaults.hue = 0
                            } else {
                                userDefaults.hslToAny(hsl: [target, userDefaults.saturation, userDefaults.lightness])
                            }
                        }
                        Text("deg")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.5))
                            .padding(.trailing, 4)
                    }
                    Text("h")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
                VStack(spacing: 2) {
                    ZStack(alignment: .trailing) {
                        TextField(
                            "",
                            value: $userDefaults.saturation,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: userDefaults.saturation) { target in
                            if target > 100 {
                                userDefaults.saturation = 100
                            } else if target < 0 {
                                userDefaults.saturation = 0
                            } else {
                                userDefaults.hslToAny(hsl: [userDefaults.hue, target, userDefaults.lightness])
                            }
                        }
                        Text("%")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.5))
                            .padding(.trailing, 4)
                    }
                    Text("s")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
                VStack(spacing: 2) {
                    ZStack(alignment: .trailing) {
                        TextField(
                            "",
                            value: $userDefaults.lightness,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: userDefaults.lightness) { target in
                            if target > 100 {
                                userDefaults.lightness = 100
                            } else if target < 0 {
                                userDefaults.lightness = 0
                            } else {
                                userDefaults.hslToAny(hsl: [userDefaults.hue, userDefaults.saturation, target])
                            }
                        }
                        Text("%")
                            .font(.footnote)
                            .foregroundColor(.primary.opacity(0.5))
                            .padding(.trailing, 4)
                    }
                    Text("l")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
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
