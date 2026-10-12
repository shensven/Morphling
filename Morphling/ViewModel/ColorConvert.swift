import Foundation
import JavaScriptCore
import SwiftUI

enum JSFunctionName: String {
    case colorMatching
    case hexToFilter
    case rgbToFilter
    case hslToFilter
}

@Observable
class ColorConvert {
    var hex: String = "000000"

    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0

    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var lightness: CGFloat = 0

    var conventedContent: String?

    // Loaded once and reused for every conversion
    private static let jsContext: JSContext? = {
        guard let url = Bundle.main.url(forResource: "converter", withExtension: "js"),
              let script = try? String(contentsOf: url, encoding: .utf8),
              let context = JSContext()
        else {
            print("Failed to load converter.js")
            return nil
        }
        context.exceptionHandler = { _, exception in
            print("converter.js: \(exception?.toString() ?? "unknown error")")
        }
        context.evaluateScript(script)
        return context
    }()
}

extension ColorConvert {
    private func invokeJSFunction(name: JSFunctionName, args: [String: Any]) -> [String: Any]? {
        guard let result = Self.jsContext?.objectForKeyedSubscript(name.rawValue)?.call(withArguments: [args]),
              result.isObject
        else {
            return nil
        }
        return result.toDictionary() as? [String: Any]
    }

    func hexToAny(hex: String) {
        // Only convert a complete 6-digit hex value, so the result never lags behind the input
        guard hex.count == 6, hex.allSatisfy(\.isHexDigit) else {
            conventedContent = nil
            return
        }

        let matching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": "#\(hex)", "colorSpace": "hex"]
        )
        applyRGB(matching?["rgb"])
        applyHSL(matching?["hsl"])

        applyFilter(invokeJSFunction(name: .hexToFilter, args: ["hex": "#\(hex)"]))
    }

    func rgbToAny(rgb: [CGFloat]) {
        let rgbArgs = ["r": rgb[0], "g": rgb[1], "b": rgb[2]]

        let matching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": rgbArgs, "colorSpace": "rgb"]
        )
        applyHex(matching?["hex"])
        applyHSL(matching?["hsl"])

        applyFilter(invokeJSFunction(name: .rgbToFilter, args: rgbArgs))
    }

    func hslToAny(hsl: [CGFloat]) {
        let hslArgs = ["h": hsl[0], "s": hsl[1], "l": hsl[2]]

        let matching = invokeJSFunction(
            name: .colorMatching,
            args: ["colorParam": hslArgs, "colorSpace": "hsl"]
        )
        applyHex(matching?["hex"])
        applyRGB(matching?["rgb"])

        applyFilter(invokeJSFunction(name: .hslToFilter, args: hslArgs))
    }

    private func applyHex(_ value: Any?) {
        if let hexWithSharp = value as? String {
            hex = hexWithSharp.dropFirst().uppercased()
        }
    }

    private func applyRGB(_ value: Any?) {
        if let rgb = value as? [String: CGFloat] {
            red = rgb["r"] ?? 0
            green = rgb["g"] ?? 0
            blue = rgb["b"] ?? 0
        }
    }

    private func applyHSL(_ value: Any?) {
        if let hsl = value as? [String: CGFloat] {
            hue = hsl["h"] ?? 0
            saturation = hsl["s"] ?? 0
            lightness = hsl["l"] ?? 0
        }
    }

    // A failed conversion clears the result instead of leaving the previous one on screen
    private func applyFilter(_ result: [String: Any]?) {
        conventedContent = result?["filter"] as? String
    }
}
