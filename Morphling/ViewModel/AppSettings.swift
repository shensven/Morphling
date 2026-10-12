import SwiftUI

@Observable
class AppSettings {
    // Keys must stay unchanged, or existing settings are lost
    private enum Key {
        static let appearance = "appearance"
        static let windowLevel = "windowLevel"
        static let currentColorFormat = "currentColorFormat"
        static let isPrefixWithFilter = "isPrefixWithFilter"
    }

    var appearance: Appearance {
        didSet {
            UserDefaults.standard.set(appearance.rawValue, forKey: Key.appearance)
            appearance.apply()
        }
    }

    /// Keeps the main window above other windows. Stored as a window level, as earlier versions did.
    var isPinned: Bool {
        didSet {
            let level: NSWindow.Level = isPinned ? .floating : .normal
            UserDefaults.standard.set(level.rawValue, forKey: Key.windowLevel)
        }
    }

    var currentColorFormat: ColorFormat {
        didSet { UserDefaults.standard.set(currentColorFormat.rawValue, forKey: Key.currentColorFormat) }
    }

    var isPrefixWithFilter: Bool {
        didSet { UserDefaults.standard.set(isPrefixWithFilter, forKey: Key.isPrefixWithFilter) }
    }

    init() {
        let defaults = UserDefaults.standard
        appearance = defaults.string(forKey: Key.appearance).flatMap { Appearance(rawValue: $0) } ?? .automatic
        isPinned = defaults.integer(forKey: Key.windowLevel) > NSWindow.Level.normal.rawValue
        currentColorFormat = defaults.string(forKey: Key.currentColorFormat)
            .flatMap { ColorFormat(rawValue: $0) } ?? .hex
        isPrefixWithFilter = defaults.bool(forKey: Key.isPrefixWithFilter)
    }
}
