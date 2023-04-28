import SwiftUI

enum ColorFormat: String, CaseIterable {
    case hex = "Hex"
    case rgb = "RGB"
    case hsl = "HSL"
}

struct ColorPickerView: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var colorConvert: ColorConvert

    var body: some View {
        HStack {
            VStack(spacing: 2) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1)
                    Color(
                        .sRGB,
                        red: colorConvert.red / 255,
                        green: colorConvert.green / 255,
                        blue: colorConvert.blue / 255
                    ).clipShape(RoundedRectangle(cornerRadius: 4))
                }.frame(width: 18, height: 18)

                Text("p")
                    .font(.footnote)
                    .hidden()
            }

            if storage.currentColorFormat == .hex {
                VStack(spacing: 2) {
                    ZStack(alignment: .leading) {
                        TextField("", text: $colorConvert.hex)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onChange(of: colorConvert.hex) { target in
                                if target.count > 6 {
                                    colorConvert.hex = "FFFFFF"
                                }
                                colorConvert.hexToAny(hex: target)
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

            if storage.currentColorFormat == .rgb {
                VStack(spacing: 2) {
                    TextField(
                        "",
                        value: $colorConvert.red,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: colorConvert.red) { target in
                        if target > 255 {
                            colorConvert.red = 255
                        } else if target < 0 {
                            colorConvert.red = 0
                        } else {
                            colorConvert.rgbToAny(rgb: [target, colorConvert.green, colorConvert.blue])
                        }
                    }
                    Text("r")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
                VStack(spacing: 2) {
                    TextField(
                        "",
                        value: $colorConvert.green,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: colorConvert.green) { target in
                        if target > 255 {
                            colorConvert.green = 255
                        } else if target < 0 {
                            colorConvert.green = 0
                        } else {
                            colorConvert.rgbToAny(rgb: [colorConvert.red, target, colorConvert.blue])
                        }
                    }
                    Text("g")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
                VStack(spacing: 2) {
                    TextField(
                        "",
                        value: $colorConvert.blue,
                        formatter: NumberFormatter()
                    )
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: colorConvert.blue) { target in
                        if target > 255 {
                            colorConvert.blue = 255
                        } else if target < 0 {
                            colorConvert.blue = 0
                        } else {
                            colorConvert.rgbToAny(rgb: [colorConvert.red, colorConvert.green, target])
                        }
                    }
                    Text("b")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
            }

            if storage.currentColorFormat == .hsl {
                VStack(spacing: 2) {
                    ZStack(alignment: .trailing) {
                        TextField(
                            "",
                            value: $colorConvert.hue,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: colorConvert.hue) { target in
                            if target > 360 {
                                colorConvert.hue = 360
                            } else if target < 0 {
                                colorConvert.hue = 0
                            } else {
                                colorConvert.hslToAny(hsl: [target, colorConvert.saturation, colorConvert.lightness])
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
                            value: $colorConvert.saturation,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: colorConvert.saturation) { target in
                            if target > 100 {
                                colorConvert.saturation = 100
                            } else if target < 0 {
                                colorConvert.saturation = 0
                            } else {
                                colorConvert.hslToAny(hsl: [colorConvert.hue, target, colorConvert.lightness])
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
                            value: $colorConvert.lightness,
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .onChange(of: colorConvert.lightness) { target in
                            if target > 100 {
                                colorConvert.lightness = 100
                            } else if target < 0 {
                                colorConvert.lightness = 0
                            } else {
                                colorConvert.hslToAny(hsl: [colorConvert.hue, colorConvert.saturation, target])
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
                Picker(selection: $storage.currentColorFormat, label: EmptyView()) {
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
