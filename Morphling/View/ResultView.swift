import SwiftUI

struct ResultView: View {
    @State private var content: String = "filter: brightness(0) saturate(100%) invert(55%) sepia(50%) saturate(392%) hue-rotate(171deg) brightness(99%) contrast(99%)"

    var body: some View {
        ScrollView {
            Text(content)
                .lineSpacing(4)
                .textSelection(.enabled)
                .padding(.vertical, 8)
                .padding(.horizontal, 4)
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
