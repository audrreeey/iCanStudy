import SwiftUI

struct WelcomePageView: View {
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    @State private var goToHome = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // Background app
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Coins indicators
                ZStack {
                    Image("coins_indicator")
                        .resizable()
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                    Text("0")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .padding(.leading, 35)
                }
                .frame(width: 129, height: 52)
                .padding(.top, -380)
                .padding(.leading, 230)
                
                // Welcome fish animation
                FocusFishAnimationsView()
                    .offset(x: -35, y: 185)
                
                Image("bubble_text_3")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .scaleEffect(0.85)
                    .offset(x: 60, y: 70)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .padding()
                
                // Home components
                VStack {
                    Text("Today's Study Time")
                        .font(Font.custom("Slackey-Regular", size: 25))
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    Text("00 : 00 : 00")
                        .font(Font.custom("Slackey-Regular", size: 50))
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    
                    GlowButtonView()
                }
                .offset(y: -125)
                
                // Main buttons
                HStack {
                    Image("shops_action_button")
                        .resizable()
                        .frame(width: 69.15, height: 86.92)
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 6)
                        .buttonStyle(PlainButtonStyle())
                    
                    Spacer().frame(width: 150)
                    
                    Image("streak_action_button")
                        .resizable()
                        .frame(width: 102.49, height: 88.91)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        .offset(x: 22)
                        .buttonStyle(PlainButtonStyle())
                }
                .offset(y: 350)
                
                // NavigationLink tersembunyi
                if goToHome {
                    HomeView()
                }
            }
            .navigationBarBackButtonHidden(true)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.none) {
                    hasLaunchedBefore = true
                    goToHome = true
                }
            }
        }
    }
}

#Preview {
    WelcomePageView()
}
