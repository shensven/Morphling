import SwiftUI

struct ContentView: View {
    @State private var windowLevel: NSWindow.Level = .normal

    func toggleWindowLevel() {
        if windowLevel == .normal {
            windowLevel = .floating
            NSApplication.shared.windows.last?.level = .floating
        } else {
            windowLevel = .normal
            NSApplication.shared.windows.last?.level = .normal
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
                    systemName: windowLevel == .floating ? "pin.fill" : "pin"
                )
                .foregroundColor(windowLevel == .floating ? Color.accentColor : Color.primary)
                .rotationEffect(.degrees(30))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
