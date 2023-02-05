import SwiftUI

struct ActionView: View {
    @EnvironmentObject var userDefaults: UserDefaults

    var body: some View {
        Button {
            let pong = userDefaults.callJavaScriptFunc()
            NSPasteboard.general.declareTypes([.string], owner: nil)
            NSPasteboard.general.setString(pong!.toString(), forType: .string)
            print(pong!)
        } label: {
            Spacer()
            Text("Copy to Pasteboard")
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
