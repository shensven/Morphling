import SwiftUI

struct OptionView: View {
    @Environment(Storage.self) var storage
    @Environment(ColorConvert.self) var colorConvert

    var body: some View {
        @Bindable var storage = storage

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
                colorConvert.convert(from: storage.currentColorFormat)
            }
            Button("Main.Clear") {
                colorConvert.convertedContent = nil
            }
        }
    }
}

#Preview {
    OptionView()
}
