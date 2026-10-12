import SwiftUI

struct ActionView: View {
    @Environment(Storage.self) var storage
    @Environment(ColorConvert.self) var colorConvert

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
            guard let output = colorConvert.output(withFilterPrefix: storage.isPrefixWithFilter) else { return }
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
        .environment(Storage())
        .environment(ColorConvert())
}
