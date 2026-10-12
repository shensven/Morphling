import AppKit
import SwiftUI

// Raw values are what UserDefaults stores, so they must stay unchanged
enum Appearance: String, CaseIterable {
    case light = "Appearance.Light"
    case dark = "Appearance.Dark"
    case automatic = "Appearance.Automatic"

    var title: LocalizedStringResource {
        switch self {
        case .light: "Appearance.Light"
        case .dark: "Appearance.Dark"
        case .automatic: "Appearance.Automatic"
        }
    }

    func apply() {
        switch self {
        case .light:
            NSApp.appearance = NSAppearance(named: .aqua)
        case .dark:
            NSApp.appearance = NSAppearance(named: .darkAqua)
        case .automatic:
            NSApp.appearance = nil
        }
    }
}
