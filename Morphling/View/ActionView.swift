import SwiftUI

struct ActionView: View {
    @Environment(AppSettings.self) var settings
    @Environment(ColorConverter.self) var converter

    var body: some View {
        if #available(macOS 26.0, *) {
            copyButton
                .buttonStyle(.glassProminent)
        } else {
            copyButton
                .buttonStyle(.borderedProminent)
        }
    }

    private var copyButton: some View {
        Button {
            guard let output = converter.output(withFilterPrefix: settings.isPrefixWithFilter) else { return }
            NSPasteboard.general.clearContents()
            NSPasteboard.general.setString(output, forType: .string)
        } label: {
            Spacer()
            Text("Main.Copy_to_Pasteboard")
            Spacer()
        }
        .controlSize(.large)
        .padding(.top)
    }
}

#Preview {
    ActionView()
        .environment(AppSettings())
        .environment(ColorConverter())
}
