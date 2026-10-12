import OSLog
import ServiceManagement
import SwiftUI

@Observable
class LaunchAtLogin {
    private static let logger = Logger(subsystem: "com.shensven.morphling", category: "LaunchAtLogin")

    var isEnabled: Bool {
        get {
            access(keyPath: \.isEnabled)
            return SMAppService.mainApp.status == .enabled
        }
        set {
            withMutation(keyPath: \.isEnabled) {
                do {
                    if newValue {
                        try SMAppService.mainApp.register()
                    } else {
                        try SMAppService.mainApp.unregister()
                    }
                } catch {
                    Self.logger.error("Failed to update the login item: \(error, privacy: .public)")
                }
            }
        }
    }
}
