import Foundation
import JavaScriptCore
import OSLog
import SwiftUI

enum ColorFormat: String, CaseIterable {
    case hex = "Hex"
    case rgb = "RGB"
    case hsl = "HSL"
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

    var convertedContent: String?

    /// Functions that converter.js exposes on `globalThis`.
    private enum JSFunctionName: String {
        case convertColor
        case hexToFilter
        case rgbToFilter
        case hslToFilter
    }

    private static let logger = Logger(subsystem: "com.shensven.morphling", category: "Converter")

    // Loaded once and reused for every conversion
    private static let jsContext: JSContext? = {
        guard let url = Bundle.main.url(forResource: "converter", withExtension: "js"),
              let script = try? String(contentsOf: url, encoding: .utf8),
              let context = JSContext()
        else {
            logger.error("Failed to load converter.js")
            return nil
        }
        context.exceptionHandler = { _, exception in
            logger.error("converter.js: \(exception?.toString() ?? "unknown error", privacy: .public)")
        }
        context.evaluateScript(script)
        return context
    }()
}

extension ColorConvert {
    /// Recomputes everything from the values of the given input format.
    func convert(from format: ColorFormat) {
        switch format {
        case .hex:
            convertFromHex()
        case .rgb:
            convertFromRGB()
        case .hsl:
            convertFromHSL()
        }
    }

    /// The text to show and copy, optionally as a complete `filter:` declaration.
    func output(withFilterPrefix: Bool) -> String? {
        guard let convertedContent else { return nil }
        return withFilterPrefix ? "filter: \(convertedContent)" : convertedContent
    }

    private func invokeJSFunction(name: JSFunctionName, args: [String: Any]) -> [String: Any]? {
        guard let result = Self.jsContext?.objectForKeyedSubscript(name.rawValue)?.call(withArguments: [args]),
              result.isObject
        else {
            return nil
        }
        return result.toDictionary() as? [String: Any]
    }

    private func convertFromHex() {
        // Only convert a complete 6-digit hex value, so the result never lags behind the input
        guard hex.count == 6, hex.allSatisfy(\.isHexDigit) else {
            convertedContent = nil
            return
        }

        let converted = invokeJSFunction(
            name: .convertColor,
            args: ["colorParam": "#\(hex)", "colorSpace": "hex"]
        )
        applyRGB(converted?["rgb"])
        applyHSL(converted?["hsl"])

        applyFilter(invokeJSFunction(name: .hexToFilter, args: ["hex": "#\(hex)"]))
    }

    private func convertFromRGB() {
        let rgbArgs = ["r": red, "g": green, "b": blue]

        let converted = invokeJSFunction(
            name: .convertColor,
            args: ["colorParam": rgbArgs, "colorSpace": "rgb"]
        )
        applyHex(converted?["hex"])
        applyHSL(converted?["hsl"])

        applyFilter(invokeJSFunction(name: .rgbToFilter, args: rgbArgs))
    }

    private func convertFromHSL() {
        let hslArgs = ["h": hue, "s": saturation, "l": lightness]

        let converted = invokeJSFunction(
            name: .convertColor,
            args: ["colorParam": hslArgs, "colorSpace": "hsl"]
        )
        applyHex(converted?["hex"])
        applyRGB(converted?["rgb"])

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
        convertedContent = result?["filter"] as? String
    }
}
