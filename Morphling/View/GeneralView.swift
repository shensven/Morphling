import SwiftUI

struct GeneralView: View {
    @Environment(\.openURL) var openURL
    @Environment(Storage.self) var storage
    @Environment(Appearance.self) var appearance
    @State var launchAtLogin = LaunchAtLogin()

    var body: some View {
        @Bindable var appearance = appearance

        Form {
            Picker("General.Appearance", selection: $appearance.friendlyName) {
                ForEach(AppearanceFriendly.allCases, id: \.self) { friendlyName in
                    Text(friendlyName.localizedString).tag(friendlyName)
                }
            }
            .onChange(of: appearance.friendlyName) { _, friendlyName in
                appearance.setFriendly(name: friendlyName)
                storage.appearance = friendlyName
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
}
