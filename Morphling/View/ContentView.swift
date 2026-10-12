import AppKit
import SwiftUI

struct ContentView: View {
    @Environment(Storage.self) var storage

    private var isPinned: Binding<Bool> {
        Binding(
            get: { storage.windowLevel == .floating },
            set: { storage.windowLevel = $0 ? .floating : .normal }
        )
    }

    var body: some View {
        VStack {
            ColorPickerView()
            ResultView()
            OptionView()
            ActionView()
        }
        .padding()
        .background(WindowLevelSetter(level: storage.windowLevel))
        .toolbar {
            Toggle(isOn: isPinned) {
                Label("Main.Keep_on_Top", systemImage: isPinned.wrappedValue ? "pin.fill" : "pin")
            }
            .toggleStyle(.button)
            .help("Main.Keep_on_Top")
        }
    }
}

/// Applies a level to the window that hosts this view, rather than guessing which window it is.
private struct WindowLevelSetter: NSViewRepresentable {
    let level: NSWindow.Level

    func makeNSView(context: Context) -> LevelView {
        LevelView()
    }

    func updateNSView(_ view: LevelView, context: Context) {
        view.level = level
    }

    final class LevelView: NSView {
        var level: NSWindow.Level = .normal {
            didSet { window?.level = level }
        }

        override func viewDidMoveToWindow() {
            super.viewDidMoveToWindow()
            window?.level = level
        }
    }
}

#Preview {
    ContentView()
}
