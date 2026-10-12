import SwiftUI

struct GeneralView: View {
    @Environment(\.openURL) var openURL
    @Environment(Storage.self) var storage
    @State var launchAtLogin = LaunchAtLogin()

    var body: some View {
        @Bindable var storage = storage

        Form {
            Picker("General.Appearance", selection: $storage.appearance) {
                ForEach(AppearanceFriendly.allCases, id: \.self) { appearance in
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
        .environment(Storage())
}
