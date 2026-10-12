import SwiftUI

struct SettingsView: View {
    private var frameWidth: CGFloat = 480

    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("Settings.General", systemImage: "gearshape")
                }
                .frame(width: frameWidth)
                .fixedSize()

            AboutView()
                .tabItem {
                    Label("Settings.About", systemImage: "info.circle")
                }
                .frame(width: frameWidth)
                .fixedSize()
        }
    }
}

#Preview {
    SettingsView()
        .environment(AppSettings())
}
