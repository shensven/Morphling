import SwiftUI

struct ResultView: View {
    @AppStorage("isPrefixWithFilter") var isPrefixWithFilter: Bool = false
    @State private var content: String = "brightness(0) saturate(100%) invert(0%) sepia(0%) saturate(0%) hue-rotate(312deg) brightness(98%) contrast(101%)"

    var body: some View {
        ScrollView {
            HStack {
                Text((isPrefixWithFilter ? "filter: " : "") + content)
                    .lineSpacing(4)
                    .textSelection(.enabled)
                    .padding(8)
                    .foregroundColor(.primary.opacity(0.9))
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
