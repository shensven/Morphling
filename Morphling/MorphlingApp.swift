import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct MorphlingApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    @AppStorage("windowLevel") var windowLevel: NSWindow.Level = .normal
    @AppStorage("selectedAppearance") var selectedAppearance = 0
    @AppStorage("currentColorFormat") var currentColorFormat: ColorFormat = .hex

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
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        NSApplication.shared.windows.first?.level = windowLevel
                        GeneralView.setAppearance(index: selectedAppearance)
                    }
                    switch currentColorFormat {
                    case .hex:
                        userDefaults.hexToAny(hex: userDefaults.hex)
                    case .rgb:
                        userDefaults.rgbToAny(rgb: [userDefaults.red, userDefaults.green, userDefaults.blue])
                    case .hsl:
                        userDefaults.hslToAny(hsl: [userDefaults.hue, userDefaults.saturation, userDefaults.lightness])
                    }
                }
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem, addition: {})
        }

        Settings {
            SettingsView()
        }
    }
}
