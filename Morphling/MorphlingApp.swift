import SwiftUI

@main
struct MorphlingApp: App {
    init() {
        NSWindow.allowsAutomaticWindowTabbing = false
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 336)
                .frame(minHeight: 360, maxHeight: .infinity)
        }
        .windowResizability(.contentSize)
        .commands {
            CommandGroup(replacing: .newItem, addition: {})
        }
    }
}
