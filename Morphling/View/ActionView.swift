import SwiftUI

struct ActionView: View {
    @AppStorage("isPrefixWithFilter") var isPrefixWithFilter: Bool = false
    @EnvironmentObject var userDefaults: UserDefaults

    var body: some View {
        Button {
            var result = userDefaults.conventedContent ?? ""
            if isPrefixWithFilter {
                result = "filter: \(result)"
            }
            if userDefaults.conventedContent != nil {
                NSPasteboard.general.declareTypes([.string], owner: nil)
                NSPasteboard.general.setString(result, forType: .string)
                print(result)
            }
        } label: {
            Spacer()
            Text("Main.Copy_to_Pasteboard")
            Spacer()
        }
        .buttonStyle(.borderedProminent)
        .controlSize(.large)
        .padding(.top)
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView()
    }
}
