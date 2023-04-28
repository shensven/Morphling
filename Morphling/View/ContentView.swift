import SwiftUI

struct ContentView: View {
    @EnvironmentObject var storage: Storage

    func toggleWindowLevel() {
        if storage.windowLevel == .normal {
            storage.windowLevel = .floating
            NSApplication.shared.windows.first?.level = .floating
        } else {
            storage.windowLevel = .normal
            NSApplication.shared.windows.first?.level = .normal
        }
    }

    var body: some View {
        VStack {
            ColorPickerView()
            ResultView()
            OptionView()
            ActionView()
        }
        .padding()
        .toolbar {
            Button {
                toggleWindowLevel()
            } label: {
                Image(
                    systemName: storage.windowLevel == .floating ? "pin.fill" : "pin"
                )
                .foregroundColor(storage.windowLevel == .floating ? Color.accentColor : Color.primary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
