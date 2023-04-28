import SwiftUI

class Storage: ObservableObject {
    @AppStorage("appearance") var appearance: AppearanceFriendly = .automatic
    @AppStorage("windowLevel") var windowLevel: NSWindow.Level = .normal
    @AppStorage("currentColorFormat") var currentColorFormat: ColorFormat = .hex
    @AppStorage("isPrefixWithFilter") var isPrefixWithFilter: Bool = false
}
