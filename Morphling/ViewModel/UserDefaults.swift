import Foundation
import JavaScriptCore

enum OriginalColor {
    case hexColor
    case rgbColor
}

enum JavaScriptFunction: String {
    case hexToFilter
}

class UserDefaults: ObservableObject {
    @Published var hexColor: String = "000000"
    @Published var rgbColor: [CGFloat] = [0.0, 0.0, 0.0]

    @Published var conventedContent: String?
}

extension UserDefaults {
    func callJavaScriptFunc() -> JSValue? {
        let path = Bundle.main.path(forResource: "converter", ofType: "js")!

        var jsString = try! String(contentsOfFile: path)
        jsString = "var window = this; \(jsString)"

        let jsContext = JSContext()
        jsContext?.evaluateScript(jsString)

        let ping = jsContext?.objectForKeyedSubscript("hexToFilter")

        let pong = ping?.call(withArguments: ["#\(hexColor)"])
        conventedContent = pong?.toString()
        return pong
    }
}
