import SwiftUI

struct OptionView: View {
    @AppStorage("isPrefixWithFilter") var isPrefixWithFilter: Bool = false
    @EnvironmentObject var userDefaults: UserDefaults

    var body: some View {
        HStack {
            Toggle(isOn: $isPrefixWithFilter) {
                HStack(spacing: 2) {
                    Text("Main.Prefix_with")
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
            Button("Main.Clear") {
                userDefaults.conventedContent = nil
            }
        }
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
    }
}
