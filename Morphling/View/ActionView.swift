import JavaScriptCore
import SwiftUI

enum JavaScriptFunction: String {
    case pong
    case hello
    case toFilter
}

struct ActionView: View {
    @State private var hover = false

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
        HStack {
            Spacer()
            Text("COPY")
                .font(.body)
                .fontWeight(.bold)
                .foregroundColor(
                    Color(.textBackgroundColor)
                )
            Spacer()
        }
        .frame(height: 40)
        .background(Color.accentColor)
        .brightness(hover ? -0.05 : 0)
        .cornerRadius(8)
        .onHover { over in
            hover = over
        }
        .onTapGesture {
            let pong = callJavaScriptFunc(name: .toFilter)
            NSPasteboard.general.declareTypes([.string], owner: nil)
            NSPasteboard.general.setString(pong!.toString(), forType: .string)
            print(pong!)
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        ActionView()
    }
}
