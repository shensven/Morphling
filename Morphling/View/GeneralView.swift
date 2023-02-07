import LaunchAtLogin
import SwiftUI

struct GeneralView: View {
    @AppStorage("selectedAppearance") var selectedAppearance = 0

    var appearance = ["Automatic", "Light", "Dark"]

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
            Picker("Appearance", selection: $selectedAppearance) {
                ForEach(0 ..< appearance.count, id: \.self) {
                    Text(NSLocalizedString(self.appearance[$0], comment: ""))
                }
            }
            .frame(width: 192)
            .onChange(of: selectedAppearance) { index in
                GeneralView.setAppearance(index: index)
            }

            LabeledContent("Language") {
                Button {
                    let prefPanePath = URL(fileURLWithPath: "/System/Library/PreferencePanes/Localization.prefPane")
                    NSWorkspace.shared.open(prefPanePath)
                } label: {
                    Text("Open System Settings")
                }
            }

            LabeledContent("Applacation") {
                LaunchAtLogin.Toggle {
                    Text("Launch at Login")
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
