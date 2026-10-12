import ServiceManagement
import SwiftUI

@Observable
class LaunchAtLogin {
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
                    print(error)
                }
            }
        }
    }
}
