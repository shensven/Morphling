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
                    Text(verbatim: "filter:")
                        .font(.body)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                        .foregroundStyle(.primary)
                        .background(Color.accentColor.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 3))
                }
            }
            Spacer()
            Button("Main.Reconvert") {
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
        .environment(Storage())
        .environment(ColorConvert())
}
