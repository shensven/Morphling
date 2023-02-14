import Foundation
import JavaScriptCore

enum OriginalColor {
    case hexColor
    case rgbColor
}

enum JSFunctionName: String {
    case colorMatching
    case hexToFilter
}

class UserDefaults: ObservableObject {
    @Published var hex: String = "000000"
    @Published var rgb: [String: CGFloat] = ["r": 0, "g": 0, "b": 0]
    @Published var hsl: [String: CGFloat] = ["h": 0, "s": 0, "l": 0]

    @Published var conventedContent: String?
}

extension UserDefaults {
    func invokeJSFunction(name: JSFunctionName, args: [String: Any]) -> JSValue? {
        let path = Bundle.main.path(forResource: "converter", ofType: "js")!

        do {
            var jsString = try String(contentsOfFile: path)
            jsString = "var window = this; \(jsString)"

            let jsContext = JSContext()
            jsContext?.evaluateScript(jsString)

            let ping = jsContext?.objectForKeyedSubscript(name.rawValue)
            let pong = ping?.call(withArguments: [args])

            return pong
        } catch {
            print(error)
        }
        return nil
    }

    func hexToAny(hex: String) {
        let pong = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": "#\(hex)", "colorSpace": "hex"]
        )
        let dict = pong?.toDictionary()

        if let rgb = dict?["rgb"] as? [String: CGFloat] {
            self.rgb = rgb
        }

        if let hsl = dict?["hsl"] as? [String: CGFloat] {
            self.hsl = hsl
        }
    }

    func rgbToAny(rgb: [String: CGFloat]) {
        let pong = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": rgb, "colorSpace": "rgb"]
        )
        let dict = pong?.toDictionary()

        if let hexWithSharp = dict?["hex"] as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }

        if let hsl = dict?["hsl"] as? [String: CGFloat] {
            self.hsl = hsl
        }
    }

    func hslToAny(hsl: [String: CGFloat]) {
        let pong = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": hsl, "colorSpace": "hsl"]
        )
        let dict = pong?.toDictionary()

        if let hexWithSharp = dict?["hex"] as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }

        if let rgb = dict?["rgb"] as? [String: CGFloat] {
            self.rgb = rgb
        }
    }
}
