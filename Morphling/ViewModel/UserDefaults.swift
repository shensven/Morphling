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
    @Published var hex: String = "000000"
    @Published var rgb8: [Int] = [0, 0, 0]
    @Published var hsl: [Int] = [0, 0, 0]

    @Published var conventedContent: String?
}

extension UserDefaults {
    func callJavaScriptFunc() -> JSValue? {
        let path = Bundle.main.path(forResource: "converter", ofType: "js")!

        do {
            var jsString = try String(contentsOfFile: path)
            jsString = "var window = this; \(jsString)"

            let jsContext = JSContext()
            jsContext?.evaluateScript(jsString)

            let ping = jsContext?.objectForKeyedSubscript("hexToFilter")

            let pong = ping?.call(withArguments: ["#\(hex)"])
            conventedContent = pong?.toString()
            return pong
        } catch {
            print(error)
        }

        return nil
    }

    func hexToRgb8(hex: String) -> [Int] {
        let scanner = Scanner(string: hex)
        var newComponent: UInt64 = 0
        scanner.scanHexInt64(&newComponent)
        return [
            Int((newComponent & 0xFF0000) >> 16),
            Int((newComponent & 0x00FF00) >> 8),
            Int(newComponent & 0x0000FF)
        ]
    }

    func rgb8ToHsl(rgb8: [Int]) -> [Int] {
        let componentR = Double(rgb8[0]) / 255.0
        let componentG = Double(rgb8[1]) / 255.0
        let componentB = Double(rgb8[2]) / 255.0

        let max = max(componentR, componentG, componentB)
        let min = min(componentR, componentG, componentB)
        let delta = max - min

        var componentH: Double = 0
        var componentS: Double = 0
        var componentL: Double = 0

        if delta == 0 {
            componentH = 0
        } else if max == componentR {
            componentH = (componentG - componentB) / delta
        } else if max == componentG {
            componentH = 2 + (componentB - componentR) / delta
        } else if max == componentB {
            componentH = 4 + (componentR - componentG) / delta
        }

        componentH *= 60
        if componentH < 0 {
            componentH += 360
        }

        componentL = (max + min) / 2

        if delta == 0 {
            componentS = 0
        } else {
            componentS = delta / (1 - abs(2 * componentL - 1))
        }

        componentS *= 100
        componentL *= 100

        return [Int(componentH), Int(componentS), Int(componentL)]
    }

    func hslToRgb8(hsl: [Int]) -> [Int] {
        let componentH = Double(hsl[0])
        let componentS = Double(hsl[1]) / 100
        let componentL = Double(hsl[2]) / 100

        let chroma = (1 - abs(2 * componentL - 1)) * componentS
        let xxx = chroma * (1 - abs((componentH / 60).truncatingRemainder(dividingBy: 2) - 1))
        let mmm = componentL - chroma / 2

        var componentR: Double = 0
        var componentG: Double = 0
        var componentB: Double = 0

        if componentH >= 0 && componentH < 60 {
            componentR = chroma
            componentG = xxx
            componentB = 0
        } else if componentH >= 60 && componentH < 120 {
            componentR = xxx
            componentG = chroma
            componentB = 0
        } else if componentH >= 120 && componentH < 180 {
            componentR = 0
            componentG = chroma
            componentB = xxx
        } else if componentH >= 180 && componentH < 240 {
            componentR = 0
            componentG = xxx
            componentB = chroma
        } else if componentH >= 240 && componentH < 300 {
            componentR = xxx
            componentG = 0
            componentB = chroma
        } else if componentH >= 300 && componentH < 360 {
            componentR = chroma
            componentG = 0
            componentB = xxx
        }

        componentR = (componentR + mmm) * 255
        componentG = (componentG + mmm) * 255
        componentB = (componentB + mmm) * 255

        return [Int(componentR), Int(componentG), Int(componentB)]
    }

    func rgb8ToHex(rgb8: [Int]) -> String {
        let conponentR = rgb8[0]
        let conponentG = rgb8[1]
        let conponentB = rgb8[2]
        let newHex = String(
            format: "%02X%02X%02X",
            Int(conponentR),
            Int(conponentG),
            Int(conponentB)
        )
        return newHex
    }
}
