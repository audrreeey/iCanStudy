import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    
    @State private var showCoinModal = false
    @State private var showShopModal = false
    @State private var showStreakModal = false
    
    @State var refreshFishes = false
    @State private var lightMove: CGFloat = -200
    
    var body: some View {
        NavigationStack {
            ZStack {
                // background laut
                Image("background_app")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // efek sunlight beams
                ZStack {
                
                    
                    ForEach(0..<12, id: \.self) { i in
                        SunlightBeam(
                            width: CGFloat.random(in: 80...150),
                            blur: CGFloat.random(in: 20...50)
                        )
                        .rotationEffect(.degrees(Double(i) * 30 + Double.random(in: -10...10)))
                        .offset(y: lightMove + CGFloat.random(in: -50...50))
                        .opacity(Double.random(in: 0.15...0.5))
                        .blendMode(.screen)
                    }
                }
                .onAppear {
                    withAnimation(.easeInOut(duration: 4).repeatForever(autoreverses: true)) {
                        lightMove = 50
                    }
                }
                
                // animasi ikan
                FishAnimationView(refreshFish: $refreshFishes)
                
                // indikator coins
                coinIndicator
                
                // title & timer
                titleSection
                
                // tombol utama
                actionButtons
                
                // modals
                if showStreakModal {
                    StreakModalView(isPresented: $showStreakModal)
                }
                if showShopModal {
                    ShopmodalView(showShopModal: $showShopModal)
                }
                if showCoinModal {
                    ModalCoin(showCoinModal: $showCoinModal)
                }
                
//                Button(action: {
//                    currentFishNames.removeAll()
//                    FishStorageManager.resetFishNames()
//                    print(FishStorageManager.getFishNames())
//                    //nanti ini bkl bekerja, sementra utk resebutton
//                }) {
//                    Image("red_back_button")
//                        .resizable()
//                        .frame(width: 69, height: 69)
//                        .padding()
//                }
//                .position(x: 300, y: 170)
//                    
//                    Button(action: {
//                        CoinControl.rewardCoins(forSeconds: 3000, context: context)
//                        //nanti ini bkl bekerja, sementra utk resebutton
//                    }) {
//                        Image("red_back_button")
//                            .resizable()
//                            .frame(width: 69, height: 69)
//                            .padding()
//                    }
//                    .position(x: 150, y: 170)
            }
            .navigationBarBackButtonHidden(true)
            .onChange(of: showShopModal) { oldValue, newValue in
                refreshFishes.toggle()
            }
        }
    }
    
    struct SunlightBeam: View {
        var width: CGFloat
        var blur: CGFloat
        
        var body: some View {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.4),
                    Color.clear
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(width: width, height: 600)
            .blur(radius: blur)
        }
    }
    
    // MARK: - Bagian UI
    var coinIndicator: some View {
        ZStack {
            Button(action: {
                AudioHelper.playSound(named: "bubble_sfx")
                showCoinModal = true
            }) {
                Image("coins_indicator")
                    .resizable()
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
            }
            
            Text("\(users.first?.coins ?? 0)")
                .font(Font.custom("Slackey-Regular", size: 15))
                .foregroundStyle(.coin)
                .opacity(0.7)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                .padding(.leading, 40)
        }
        .frame(width: 129, height: 52)
        .padding(.top, -370)
        .padding(.leading, 250)
        
                        
    }
    
    var titleSection: some View {
        VStack {
            Text("Today's Study Time")
                .font(Font.custom("Slackey-Regular", size: 25))
                .foregroundStyle(Color.white)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
            
            Text(StudySessionManager.getTotalTimeToday(context: context))
                .font(Font.custom("Slackey-Regular", size: 50))
                .foregroundStyle(Color.white)
                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
            
            NavigationLink(destination: TimersView()) {
                GlowButtonView()
            }
            .buttonStyle(PlainButtonStyle())
        }
        .offset(y: -125)
    }
    
    var actionButtons: some View {
        HStack {
            Button(action: {
                showShopModal = true
                AudioHelper.playSound(named: "bubble_sfx")
            }) {
                Image("shops_action_button")
                    .resizable()
                    .frame(width: 69.15, height: 86.92)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
            }
            .buttonStyle(PlainButtonStyle())
            
            Spacer().frame(width: 150)
            
            Button(action: {
                showStreakModal = true
                AudioHelper.playSound(named: "bubble_sfx")
            }) {
                Image("streak_action_button")
                    .resizable()
                    .frame(width: 102.49, height: 88.91)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(x: 20)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .offset(y: 350)
    }
}

#Preview {
    HomeView().modelContainer(for: [User.self, StudySession.self])
}
