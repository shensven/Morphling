import SwiftUI

struct ResultView: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var colorConvert: ColorConvert

    var body: some View {
        ScrollView {
            HStack {
                if colorConvert.conventedContent != nil {
                    Text((storage.isPrefixWithFilter ? "filter: " : "") + (colorConvert.conventedContent ?? ""))
                        .lineSpacing(4)
                        .textSelection(.enabled)
                        .padding(8)
                        .foregroundColor(.primary.opacity(0.9))
                }
                Spacer()
            }
            Spacer()
        }
        .background(Color(.textBackgroundColor))
        .cornerRadius(8)
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
