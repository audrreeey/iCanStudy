import SwiftUI

struct WelcomeView: View {
    @State private var isAnimating = false
    @State private var showNext = false

    var body: some View {
        ZStack {
            // Background
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Image("welcome_fish_1")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(0.8)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(x: -15, y: -30)
                    .rotationEffect(.degrees(isAnimating ? 21 : 0))
                    .animation(
                        .bouncy(duration: 0.5)
                        .repeatForever(autoreverses: true),
                        value: isAnimating
                    )

                Text("Tap to continue")
                    .font(Font.custom("Slackey-Regular", size: 17))
                    .opacity(0.8)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(y: -80)
            }

            Image("bubble_text_1")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.6)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                .offset(x: 90, y: -170)

            Image("seaweed")
                .resizable()
                .scaledToFit()
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                .offset(x: 0, y: 230)
                .scaleEffect(1.3)

            // Blur Transition Layer
            if showNext {
                WelcomeView2()
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.default) {
                showNext = true
            }
        }
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    WelcomeView()
}
