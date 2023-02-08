import LaunchAtLogin
import SwiftUI

struct GeneralView: View {
    @AppStorage("selectedAppearance") var selectedAppearance = 0

    var appearance = ["General.Automatic", "General.Light", "General.Dark"]

    static func setAppearance(index: Int) {
        switch index {
        case 0: NSApp.appearance = nil
        case 1: NSApp.appearance = NSAppearance(named: .aqua)
        case 2: NSApp.appearance = NSAppearance(named: .darkAqua)
        default: NSApp.appearance = nil
        }
    }

    var body: some View {
        Form {
            Picker("General.Appearance", selection: $selectedAppearance) {
                ForEach(0 ..< appearance.count, id: \.self) {
                    Text(NSLocalizedString(self.appearance[$0], comment: ""))
                }
            }
            .frame(width: 192)
            .onChange(of: selectedAppearance) { index in
                GeneralView.setAppearance(index: index)
            }

            LabeledContent("General.Language") {
                Button {
                    let prefPanePath = URL(fileURLWithPath: "/System/Library/PreferencePanes/Localization.prefPane")
                    NSWorkspace.shared.open(prefPanePath)
                } label: {
                    Text("General.Open_System_Settings")
                }
            }

            LabeledContent("General.Applacation") {
                LaunchAtLogin.Toggle {
                    Text("General.Launch_at_Login")
                }
            }
        }
        .frame(width: 272)
        .padding()
    }
}

struct GeneralView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralView()
    }
}
