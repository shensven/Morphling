import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("Settings.General", systemImage: "gearshape")
                }
                .frame(width: 448)
                .fixedSize()

            AboutView()
                .tabItem {
                    Label("Settings.About", systemImage: "info.circle")
                }
                .frame(width: 448)
                .fixedSize()
        }
    }
}

#Preview {
    SettingsView()
}
