import SwiftUI

struct ResultView: View {
    @AppStorage("isPrefixWithFilter") var isPrefixWithFilter: Bool = false
    @EnvironmentObject var userDefaults: UserDefaults

    var body: some View {
        ScrollView {
            HStack {
                if userDefaults.conventedContent != nil {
                    Text((isPrefixWithFilter ? "filter: " : "") + (userDefaults.conventedContent ?? ""))
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
