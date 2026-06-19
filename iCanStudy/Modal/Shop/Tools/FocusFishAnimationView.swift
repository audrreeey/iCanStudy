import SwiftUI

struct FocusFishAnimationsView: View {
    @State private var bounce = false
    @State private var rotate = false
    @State private var stopAnimation = false

    var body: some View {
        ZStack {
            
            Image("welcome_fish_2")
                .resizable()
                .scaledToFit()
                .scaleEffect(0.35)
                .scaleEffect(bounce ? 2.05 : 1.95)
                .rotationEffect(.degrees(rotate ? 10 : 0))
                .animation(
                    .easeInOut(duration: 1.2).repeatForever(autoreverses: true),
                    value: rotate
                )
            
                .onAppear {
                    
                    DispatchQueue.main.async{
                        startAnimation()
                    }
                }
        }
    }

    func startAnimation() {
        // Start animations only if not stopped
        if !stopAnimation {
            bounce.toggle()
            rotate.toggle()
            
        }
    }
}

#Preview {
    FocusFishAnimationsView()
}
