import SwiftUI

struct OptionView: View {
    @State private var isWrap: Bool = false
    @State private var isPropertynNameInclude: Bool = false

    var body: some View {
        HStack {
            Toggle(isOn: $isPropertynNameInclude) {
                Text("Include property name")
            }
            Spacer()
        }
    }
}

struct OptionView_Previews: PreviewProvider {
    static var previews: some View {
        OptionView()
    }
}
