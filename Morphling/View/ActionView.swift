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
            var result = colorConvert.conventedContent ?? ""
            if storage.isPrefixWithFilter {
                result = "filter: \(result)"
            }
            if colorConvert.conventedContent != nil {
                NSPasteboard.general.declareTypes([.string], owner: nil)
                NSPasteboard.general.setString(result, forType: .string)
            }
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
}
