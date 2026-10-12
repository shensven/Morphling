import SwiftUI

struct ResultView: View {
    @Environment(Storage.self) var storage
    @Environment(ColorConvert.self) var colorConvert

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
        .background(Color.primary.opacity(0.05))
        .cornerRadius(8)
    }
}

#Preview {
    ResultView()
}
