import SwiftUI

struct ContentView: View {
    @Environment(Storage.self) var storage

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

#Preview {
    ContentView()
}
