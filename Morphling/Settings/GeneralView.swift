import SwiftUI

struct GeneralView: View {
    @Environment(\.openURL) var openURL
    @Environment(AppSettings.self) var settings
    @State var launchAtLogin = LaunchAtLogin()

    var body: some View {
        @Bindable var settings = settings

        Form {
            Picker("General.Appearance", selection: $settings.appearance) {
                ForEach(Appearance.allCases, id: \.self) { appearance in
                    Text(appearance.title).tag(appearance)
                }
            }

            LabeledContent("General.Language") {
                Button("General.Open_System_Settings") {
                    openURL(URL(string: "x-apple.systempreferences:com.apple.Localization-Settings.extension")!)
                }
            }

            LabeledContent("General.Application") {
                Toggle(isOn: $launchAtLogin.isEnabled) {
                    Text("General.Launch_at_Login")
                }
            }
        }
        .frame(width: 264)
        .padding()
    }
}

#Preview {
    GeneralView()
        .environment(AppSettings())
}
