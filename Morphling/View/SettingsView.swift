import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("Settings.General", systemImage: "gearshape")
                }
                .frame(width: 400)
                .fixedSize()

            ColorView()
                .tabItem {
                    Label("Color", systemImage: "drop.fill")
                }
                .frame(width: 400, height: 290)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
