import AppKit
import SwiftUI

struct ContentView: View {
    @Environment(Storage.self) var storage

    var body: some View {
        @Bindable var storage = storage

        VStack {
            ColorPickerView()
            ResultView()
            OptionView()
            ActionView()
        }
        .padding()
        .background(WindowLevelSetter(level: storage.isPinned ? .floating : .normal))
        .toolbar {
            Toggle(isOn: $storage.isPinned) {
                Label("Main.Keep_on_Top", systemImage: storage.isPinned ? "pin.fill" : "pin")
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
        .environment(Storage())
        .environment(ColorConvert())
}
