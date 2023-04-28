import AppKit
import SwiftUI

enum AppearanceFriendly: String, CaseIterable {
    case light = "Appearance.Light"
    case dark = "Appearance.Dark"
    case automatic = "Appearance.Automatic"

    var localizedString: LocalizedStringKey {
        LocalizedStringKey(rawValue)
    }
}

class Appearance: ObservableObject {
    @Published var friendlyName: AppearanceFriendly = .automatic
}

extension Appearance {
    func setFriendly(name: AppearanceFriendly) {
        switch name {
        case .light:
            NSApp.appearance = NSAppearance(named: .aqua)
        case .dark:
            NSApp.appearance = NSAppearance(named: .darkAqua)
        case .automatic:
            NSApp.appearance = nil
        }
    }
}
