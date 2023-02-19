import Foundation
import JavaScriptCore
import SwiftUI

enum JSFunctionName: String {
    case colorMatching
    case hexToFilter
    case rgbToFilter
    case hslToFilter
}

class UserDefaults: ObservableObject {
    @Published var hex: String = "000000"

    @Published var red: CGFloat = 0
    @Published var green: CGFloat = 0
    @Published var blue: CGFloat = 0

    @Published var hue: CGFloat = 0
    @Published var saturation: CGFloat = 0
    @Published var lightness: CGFloat = 0

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
            red = rgb["r"] ?? 0
            green = rgb["g"] ?? 0
            blue = rgb["b"] ?? 0
        }
        if let hsl = dictColorMatching?["hsl"] as? [String: CGFloat] {
            hue = hsl["h"] ?? 0
            saturation = hsl["s"] ?? 0
            lightness = hsl["l"] ?? 0
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

    func rgbToAny(rgb: [CGFloat]) {
        let pongColorMatching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": ["r": red, "g": green, "b": blue], "colorSpace": "rgb"]
        )
        let dict = pongColorMatching?.toDictionary()
        if let hexWithSharp = dict?["hex"] as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }
        if let hsl = dict?["hsl"] as? [String: CGFloat] {
            hue = hsl["h"] ?? 0
            saturation = hsl["s"] ?? 0
            lightness = hsl["l"] ?? 0
        }

        let pongRgbToFilter = invokeJSFunction(
            name: .rgbToFilter,
            args: ["r": rgb[0], "g": rgb[1], "b": rgb[2]]
        )
        let dictRgbToFilter = pongRgbToFilter?.toDictionary()
        if let filter = dictRgbToFilter?["filter"] as? String {
            conventedContent = filter
        }
    }

    func hslToAny(hsl: [CGFloat]) {
        let pongColorMatching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": ["h": hue, "s": saturation, "l": lightness], "colorSpace": "hsl"]
        )
        let dict = pongColorMatching?.toDictionary()

        if let hexWithSharp = dict?["hex"] as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }

        if let rgb = dict?["rgb"] as? [String: CGFloat] {
            red = rgb["r"] ?? 0
            green = rgb["g"] ?? 0
            blue = rgb["b"] ?? 0
        }

        let pongHslToFilter = invokeJSFunction(
            name: .hslToFilter,
            args: ["h": hsl[0], "s": hsl[1], "l": hsl[2]]
        )
        let dictHslToFilter = pongHslToFilter?.toDictionary()
        if let filter = dictHslToFilter?["filter"] as? String {
            conventedContent = filter
        }
    }
}
