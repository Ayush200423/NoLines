import SwiftUI

struct SplashScreenView: View {
    @State var isActive: Bool = false
    @State private var size = 1.95
    @State private var opacity = 0.5
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    var body: some View {
        if isActive {
            ContentView()
        } else {
            VStack {
                VStack {
                    Image(colorScheme == .light ? "splash-light" : "splash-dark")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 125)
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 2.00
                        self.opacity = 1.00
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline:.now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
