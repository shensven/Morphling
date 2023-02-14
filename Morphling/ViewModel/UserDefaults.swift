import Foundation
import JavaScriptCore

enum OriginalColor {
    case hexColor
    case rgbColor
}

enum JSFunctionName: String {
    case colorMatching
    case hexToFilter
    case rgbToFilter
    case hslToFilter
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
        let pongColorMatching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": "#\(hex)", "colorSpace": "hex"]
        )
        let dictColorMatching = pongColorMatching?.toDictionary()
        if let rgb = dictColorMatching?["rgb"] as? [String: CGFloat] {
            self.rgb = rgb
        }
        if let hsl = dictColorMatching?["hsl"] as? [String: CGFloat] {
            self.hsl = hsl
        }

        let pongHexToFilter = invokeJSFunction(
            name: .hexToFilter,
            args: ["hex": "#\(hex)"]
        )
        let dictHexToFilter = pongHexToFilter?.toDictionary()
        if let filter = dictHexToFilter?["filter"] as? String {
            conventedContent = filter
        }
    }

    func rgbToAny(rgb: [String: CGFloat]) {
        let pongColorMatching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": rgb, "colorSpace": "rgb"]
        )
        let dict = pongColorMatching?.toDictionary()
        if let hexWithSharp = dict?["hex"] as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }
        if let hsl = dict?["hsl"] as? [String: CGFloat] {
            self.hsl = hsl
        }

        let pongRgbToFilter = invokeJSFunction(
            name: .rgbToFilter,
            args: [
                "r": rgb["r"] ?? 0,
                "g": rgb["g"] ?? 0,
                "b": rgb["b"] ?? 0
            ]
        )
        let dictRgbToFilter = pongRgbToFilter?.toDictionary()
        if let filter = dictRgbToFilter?["filter"] as? String {
            conventedContent = filter
        }
    }

    func hslToAny(hsl: [String: CGFloat]) {
        let pongColorMatching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": hsl, "colorSpace": "hsl"]
        )
        let dict = pongColorMatching?.toDictionary()

        if let hexWithSharp = dict?["hex"] as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }

        if let rgb = dict?["rgb"] as? [String: CGFloat] {
            self.rgb = rgb
        }

        let pongHslToFilter = invokeJSFunction(
            name: .hslToFilter,
            args: [
                "h": rgb["h"] ?? 0,
                "s": rgb["s"] ?? 0,
                "l": rgb["l"] ?? 0
            ]
        )
        let dictHslToFilter = pongHslToFilter?.toDictionary()
        if let filter = dictHslToFilter?["filter"] as? String {
            conventedContent = filter
        }
    }
}
