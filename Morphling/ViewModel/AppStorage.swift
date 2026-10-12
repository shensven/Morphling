import SwiftUI

@Observable
class Storage {
    var appearance: AppearanceFriendly {
        didSet {
            UserDefaults.standard.set(appearance.rawValue, forKey: "appearance")
            appearance.apply()
        }
    }

    var windowLevel: NSWindow.Level {
        didSet { UserDefaults.standard.set(windowLevel.rawValue, forKey: "windowLevel") }
    }

    var currentColorFormat: ColorFormat {
        didSet { UserDefaults.standard.set(currentColorFormat.rawValue, forKey: "currentColorFormat") }
    }

    var isPrefixWithFilter: Bool {
        didSet { UserDefaults.standard.set(isPrefixWithFilter, forKey: "isPrefixWithFilter") }
    }

    init() {
        let defaults = UserDefaults.standard
        appearance = defaults.string(forKey: "appearance").flatMap { AppearanceFriendly(rawValue: $0) } ?? .automatic
        windowLevel = (defaults.object(forKey: "windowLevel") as? Int).map { NSWindow.Level(rawValue: $0) } ?? .normal
        currentColorFormat = defaults.string(forKey: "currentColorFormat").flatMap { ColorFormat(rawValue: $0) } ?? .hex
        isPrefixWithFilter = defaults.bool(forKey: "isPrefixWithFilter")
    }
}
