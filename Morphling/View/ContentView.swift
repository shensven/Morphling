import SwiftUI

struct ContentView: View {
    @AppStorage("windowLevel") var windowLevel: NSWindow.Level = .normal

    func toggleWindowLevel() {
        if windowLevel == .normal {
            windowLevel = .floating
            NSApplication.shared.windows.first?.level = .floating
        } else {
            windowLevel = .normal
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
                    systemName: windowLevel == .floating ? "pin.fill" : "pin"
                )
                .foregroundColor(windowLevel == .floating ? Color.accentColor : Color.primary)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                NSApplication.shared.windows.first?.level = windowLevel
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
