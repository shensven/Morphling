import SwiftUI

struct ResultView: View {
    @Environment(Storage.self) var storage
    @Environment(ColorConvert.self) var colorConvert

    var body: some View {
        ScrollView {
            if let output = colorConvert.output(withFilterPrefix: storage.isPrefixWithFilter) {
                Text(output)
                    .lineSpacing(4)
                    .textSelection(.enabled)
                    .padding(8)
                    .foregroundStyle(.primary.opacity(0.9))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .background(Color.primary.opacity(0.05))
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview {
    ResultView()
        .environment(Storage())
        .environment(ColorConvert())
}
