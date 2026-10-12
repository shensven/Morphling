import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct MorphlingApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let storage = Storage()
    let colorConvert = ColorConvert()

    init() {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 352)
                .frame(minHeight: 360, maxHeight: .infinity)
                .environment(storage)
                .environment(colorConvert)
                .onAppear {
                    storage.appearance.apply()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        NSApplication.shared.windows.first?.level = storage.windowLevel
                    }
                    colorConvert.convert(from: storage.currentColorFormat)
                }
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem, addition: {})
        }

        Settings {
            SettingsView()
                .environment(storage)
        }
    }
}
