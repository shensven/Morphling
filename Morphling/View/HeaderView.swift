import SwiftUI

enum RGB: String, CaseIterable {
    case r, g, b
}

enum HSL: String, CaseIterable {
    case h, s, l
}

enum ColorFormat: String, CaseIterable {
    case hex = "Hex"
    case rgb = "RGB"
    case hsl = "HSL"
}

struct HeaderView: View {
    @AppStorage("currentColorFormat") var currentColorFormat: ColorFormat = .hex

    @State private var hex: String = "FFFFFF"
    @State private var rgb: [Int] = [0, 0, 0]
    @State private var hsl: [Int] = [0, 0, 0]

    var body: some View {
        HStack {
            if currentColorFormat == .hex {
                VStack(spacing: 2) {
                    TextField("", text: $hex)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Text("#")
                        .font(.footnote)
                        .foregroundColor(.primary.opacity(0.7))
                }
            }

            if currentColorFormat == .rgb {
                ForEach(RGB.allCases, id: \.self) { item in
                    VStack(spacing: 2) {
                        TextField(
                            "",
                            value: $rgb[RGB.allCases.firstIndex(of: item) ?? 0],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())

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
                            value: $hsl[HSL.allCases.firstIndex(of: item) ?? 0],
                            formatter: NumberFormatter()
                        )
                        .textFieldStyle(RoundedBorderTextFieldStyle())
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

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
