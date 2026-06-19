import SwiftUI

struct GlowButtonView: View {
    @State private var glow = false

    var body: some View {
    
            
            Text("FOCUS")
                .font(Font.custom("Slackey-Regular", size: 33))
                .foregroundColor(.white)
                .fontWeight(.bold)
                .frame(width: 180, height: 52)
                .offset(y:-3)
                .background(
                    Image("button_confirmation")
                        .shadow(color: Color.white.opacity(glow ? 0.9 : 0.3),
                                radius: glow ? 20 : 5)
                )
                .foregroundColor(.white)
        .onAppear {
            withAnimation(
                Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)
            ) {
                glow.toggle()
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        GlowButtonView()
    }
}
