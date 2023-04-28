import LaunchAtLogin
import SwiftUI

struct GeneralView: View {
    @EnvironmentObject var storage: Storage
    @EnvironmentObject var appearance: Appearance

    var body: some View {
        Form {
            Picker("General.Appearance", selection: $appearance.friendlyName) {
                ForEach(AppearanceFriendly.allCases, id: \.self) { friendlyName in
                    Text(friendlyName.localizedString).tag(friendlyName)
                }
            }
            .onChange(of: appearance.friendlyName) { friendlyName in
                appearance.setFriendly(name: friendlyName)
                storage.appearance = friendlyName
            }

            LabeledContent("General.Language") {
                Button {
                    let prefPanePath = URL(fileURLWithPath: "/System/Library/PreferencePanes/Localization.prefPane")
                    NSWorkspace.shared.open(prefPanePath)
                } label: {
                    Text("General.Open_System_Settings")
                }
            }

            LabeledContent("General.Application") {
                LaunchAtLogin.Toggle {
                    Text("General.Launch_at_Login")
                }
            }
        }
        .frame(width: 264)
        .padding()
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
