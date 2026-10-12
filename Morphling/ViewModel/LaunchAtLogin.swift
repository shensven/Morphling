import ServiceManagement
import SwiftUI

class LaunchAtLogin: ObservableObject {
    var isEnabled: Bool {
        get {
            SMAppService.mainApp.status == .enabled
        }
        set {
            objectWillChange.send()
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
