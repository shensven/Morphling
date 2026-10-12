import SwiftUI

struct ResultView: View {
    @Environment(AppSettings.self) var settings
    @Environment(ColorConverter.self) var converter

    var body: some View {
        ScrollView {
            if let output = converter.output(withFilterPrefix: settings.isPrefixWithFilter) {
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
        .environment(AppSettings())
        .environment(ColorConverter())
}
