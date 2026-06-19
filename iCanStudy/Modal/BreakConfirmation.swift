import SwiftUI

struct BreakConfirmation: View {
    @Binding var isPresented: Bool
    var totalSeconds: Int
    var RemainingSeconds: Int
    var studiedSeconds: Int
    @Binding var breakLimit: Int
    var onContinue: () -> Void

    @State private var continueConfirmation = false
    @State private var showBreakSession = false
    
    @State private var autoContinueSeconds = 5
    @State private var autoContinueTimer: Timer? = nil

    var formattedTime: String {
        let hours = studiedSeconds / 3600
        let minutes = (studiedSeconds % 3600) / 60
        let seconds = studiedSeconds % 60
        
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .blur(radius: 10)

            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 0.7920315862, green: 0.5732310414, blue: 0.3168769479, alpha: 1)))
                    .frame(width: 322, height: 430)

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 1, green: 0.940058589, blue: 0.7803176045, alpha: 1)))
                    .frame(width: 295, height: 380)
                    .shadow(color: .black.opacity(0.5), radius: 5)

                ZStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(Color(#colorLiteral(red: 0.2433364689, green: 0.2634049356, blue: 0.7736426592, alpha: 1)))
                        .frame(width: 220, height: 50)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    Text("BREAK")
                        .font(Font.custom("Slackey-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 5, x: 5)
                }
                .offset(y: -200)

                VStack {
                    Text("STUDY TIME")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))

                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 220, height: 42)

                        Text(formattedTime)
                            .font(Font.custom("Slackey-Regular", size: 29))
                            .fontWeight(.bold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    }
                    .offset(y: -10)
                }
                .offset(y: -100)

                VStack {
                    Text("REWARD")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 220, height: 42)

                        HStack {
                            Image("Seashell")
                                .offset(y: 2)
                            Text("\(CoinControl.calcCoins(forSeconds: studiedSeconds))")
                                .font(Font.custom("Slackey-Regular", size: 29))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                                .padding(.leading,-10)
                        }
                    }
                    .offset(y: -15)
                }
                .offset(y: -20)
            }

            VStack {
                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    stopAutoContinueCountdown()
                    if breakLimit < 5 {
                            breakLimit += 1
                            showBreakSession = true
                        } else {
                            print("breaknya habis, lanjut belajar !!")
                        }
                }) {
                    ZStack {
                       
                        Image("break_button")
                            .resizable()
                            .frame(width: 160, height: 50)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        VStack {
                            Text("5 MIN BREAK")
                                .font(Font.custom("Slackey-Regular", size: 13))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .offset(y: -2)
                            Text("\(breakLimit) / 5")
                                .font(Font.custom("Slackey-Regular", size: 13))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .offset(y: -5)
                        }
                    }
                    .padding(.top, 160)
                }

                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    stopAutoContinueCountdown()
                    isPresented = false   // tutup modal
                    onContinue()
                }) {
                    ZStack {
                        Image("button_confirmation")
                            .resizable()
                            .frame(width: 160, height: 42)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        Text("Continue (\(autoContinueSeconds))")
                            .font(Font.custom("Slackey-Regular", size: 13))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .offset(y: -2)
                    }
                    .padding(.top, 0)
                }
            }
            .offset(y: 20)
            
            .fullScreenCover(isPresented: $showBreakSession) {
                BreakSessionView(isPresented: $showBreakSession, initialSeconds: 300, onContinue: {
                    isPresented = false   // tutup BreakConfirmation
                    onContinue()          // kembali ke belajar, lanjutkan timer
                })
            }

        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
        .onAppear {
            startAutoContinueCountdown()
        }
        .onDisappear {
            stopAutoContinueCountdown()
        }
    }
        
    
    func startAutoContinueCountdown() {
        autoContinueTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if autoContinueSeconds > 0 {
                autoContinueSeconds -= 1
            } else {
                stopAutoContinueCountdown()
                isPresented = false
                onContinue()
            }
        }
    }

    func stopAutoContinueCountdown() {
        autoContinueTimer?.invalidate()
        autoContinueTimer = nil
    }

}

