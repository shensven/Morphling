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
    let appearance = Appearance()
    let colorConvert = ColorConvert()

    init() {
        NSWindow.allowsAutomaticWindowTabbing = false
        appearance.friendlyName = storage.appearance
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 352)
                .frame(minHeight: 360, maxHeight: .infinity)
                .environmentObject(storage)
                .environmentObject(colorConvert)
                .onAppear {
                    appearance.setFriendly(name: storage.appearance)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        NSApplication.shared.windows.first?.level = storage.windowLevel
                    }
                    switch storage.currentColorFormat {
                    case .hex:
                        colorConvert.hexToAny(hex: colorConvert.hex)
                    case .rgb:
                        colorConvert.rgbToAny(rgb: [colorConvert.red, colorConvert.green, colorConvert.blue])
                    case .hsl:
                        colorConvert.hslToAny(hsl: [colorConvert.hue, colorConvert.saturation, colorConvert.lightness])
                    }
                }
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem, addition: {})
        }

        Settings {
            SettingsView()
                .environmentObject(storage)
                .environmentObject(appearance)
        }
    }
}
