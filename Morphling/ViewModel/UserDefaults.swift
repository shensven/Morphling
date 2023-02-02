import Foundation

enum CurrentColor {
    case hexColor
    case rgbColor
}

class UserDefaults: ObservableObject {
    @Published var hexColor: String = "000000"
    @Published var rgbColor: [CGFloat] = [0.0, 0.0, 0.0]

    @Published var conventedContent: [CGFloat] = [0.0, 0.0, 0.0]
}
