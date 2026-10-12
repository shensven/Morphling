import SwiftUI

struct ActionView: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var colorConvert: ColorConvert

    var body: some View {
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
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding(.top)
    }
}

#Preview {
    ActionView()
}
