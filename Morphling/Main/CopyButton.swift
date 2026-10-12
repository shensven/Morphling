import SwiftUI

struct CopyButton: View {
    @Environment(AppSettings.self) var settings
    @Environment(ColorConverter.self) var converter

    var body: some View {
        if #available(macOS 26.0, *) {
            button
                .buttonStyle(.glassProminent)
        } else {
            button
                .buttonStyle(.borderedProminent)
        }
    }

    private var button: some View {
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
    CopyButton()
        .environment(AppSettings())
        .environment(ColorConverter())
}
