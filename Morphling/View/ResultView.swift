import SwiftUI

struct ResultView: View {
    @Environment(Storage.self) var storage
    @Environment(ColorConvert.self) var colorConvert

    var body: some View {
        ScrollView {
            HStack {
                if colorConvert.convertedContent != nil {
                    Text((storage.isPrefixWithFilter ? "filter: " : "") + (colorConvert.convertedContent ?? ""))
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
