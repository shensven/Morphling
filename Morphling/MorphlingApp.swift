import SwiftUI

@main
struct MorphlingApp: App {
    @State private var settings = AppSettings()
    @State private var converter = ColorConverter()

    var body: some Scene {
        // A single Window (not WindowGroup) means one window, no tabs, no "New Window",
        // and the app quits when it closes
        Window(Text(verbatim: "Morphling"), id: "main") {
            ContentView()
                .frame(width: 352)
                .frame(minHeight: 360, maxHeight: .infinity)
                .environment(settings)
                .environment(converter)
                .onAppear {
                    settings.appearance.apply()
                    converter.convert(from: settings.currentColorFormat)
                }
        }
        .windowResizability(.contentSize)

        Settings {
            SettingsView()
                .environment(settings)
        }
    }
}
