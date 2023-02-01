import JavaScriptCore
import SwiftUI

enum JavaScriptFunction: String {
    case pong
    case hello
    case toFilter
}

struct ActionView: View {
    func callJavaScriptFunc(name: JavaScriptFunction) -> JSValue? {
        let converter_js = Bundle.main.path(forResource: "converter", ofType: "js")!
        let jsString = try! String(contentsOfFile: converter_js)
        let jsContext = JSContext()
        jsContext?.evaluateScript(jsString)
        let ping = jsContext?.objectForKeyedSubscript(name.rawValue)
        let pong = ping?.call(withArguments: [])
        return pong
    }

    var body: some View {
        Button {
            let pong = callJavaScriptFunc(name: .toFilter)
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
