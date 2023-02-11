import SwiftUI

@main
struct MorphlingApp: App {
    let userDefaults = UserDefaults()

    init() {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 352)
                .frame(minHeight: 360, maxHeight: .infinity)
                .environmentObject(userDefaults)
                .tag("ContentView")
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem, addition: {})
        }
        Settings {
            SettingsView().tag("SettingsView")
        }
    }
}
