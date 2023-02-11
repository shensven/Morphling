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
                    Label("Settings.About", systemImage: "drop.fill")
                }
                .frame(width: 448)
                .fixedSize()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
