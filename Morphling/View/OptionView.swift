import SwiftUI

struct OptionView: View {
    @Environment(AppSettings.self) var settings
    @Environment(ColorConverter.self) var converter

    var body: some View {
        @Bindable var settings = settings

        HStack {
            Toggle(isOn: $settings.isPrefixWithFilter) {
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
                converter.convert(from: settings.currentColorFormat)
            }
            Button("Main.Clear") {
                converter.filter = nil
            }
        }
    }
}

#Preview {
    OptionView()
        .environment(AppSettings())
        .environment(ColorConverter())
}
