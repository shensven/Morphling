import SwiftUI

struct OptionView: View {
    @State private var isPropertynNameInclude: Bool = true

    var body: some View {
        HStack {
            Toggle(isOn: $isPropertynNameInclude) {
                HStack(spacing: 0) {
                    Text("Prefix with ")
                    Text("filter:")
                        .font(.body)
                        .padding(.vertical, 1)
                        .padding(.horizontal, 4)
                        .foregroundColor(.primary)
                        .background(Color.accentColor.opacity(0.1))
                        .cornerRadius(3)
                }
            }
            Spacer()
        }
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
    }
}
