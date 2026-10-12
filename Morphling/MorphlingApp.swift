import SwiftUI

@main
struct MorphlingApp: App {
    @State private var storage = Storage()
    @State private var colorConvert = ColorConvert()

    var body: some Scene {
        // A single Window (not WindowGroup) means one window, no tabs, no "New Window",
        // and the app quits when it closes
        Window(Text(verbatim: "Morphling"), id: "main") {
            ContentView()
                .frame(width: 352)
                .frame(minHeight: 360, maxHeight: .infinity)
                .environment(storage)
                .environment(colorConvert)
                .onAppear {
                    storage.appearance.apply()
                    colorConvert.convert(from: storage.currentColorFormat)
                }
        }
        .windowResizability(.contentSize)

        Settings {
            SettingsView()
                .environment(storage)
        }
    }
}
