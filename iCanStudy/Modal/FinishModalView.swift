import SwiftUI
import AVFoundation

struct FinishModalView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    var totalSeconds: Int
    var RemainingSeconds: Int

    @State private var continueConfirmation = false
    @State private var hasPlayedSound = false
    @State private var audioPlayer: AVAudioPlayer?

    var formattedTime: String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
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
                    Text("FINISH")
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
                .offset(y: -90)

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
                            Text("\(CoinControl.calcCoins(forSeconds: totalSeconds))")
                                .font(Font.custom("Slackey-Regular", size: 29))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                                .padding(.leading,-10)
                        }
                    }
                    .offset(y: -15)
                }
                .offset(y: 0)
            }
            
            VStack {
                Button(action: {
                    audioPlayer?.stop() // Matikan suara
                    dismiss()
                }) {
                    ZStack {
                        Image("button_confirmation")
                            .resizable()
                            .frame(width: 180, height: 50)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                        Text("CLAIM")
                            .font(Font.custom("Slackey-Regular", size: 26))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .offset(y: -2)
                    }
                    .padding(.top, 0)
                }
            }
            .offset(y: 100)
        }
        .onAppear {
            if !hasPlayedSound {
                playSoundOnce()
                hasPlayedSound = true
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }

    private func playSoundOnce() {
        if let soundURL = Bundle.main.url(forResource: "finish_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.volume = 0.3 // 🔊 Volume kecil (30%)
                audioPlayer?.play()
            } catch {
                print("Gagal memutar suara:", error.localizedDescription)
            }
        } else {
            print("File finish_sound.mp3 tidak ditemukan di bundle.")
        }
    }
}

#Preview {
    FinishModalView(isPresented: .constant(true), totalSeconds: 200, RemainingSeconds: 300)
}
