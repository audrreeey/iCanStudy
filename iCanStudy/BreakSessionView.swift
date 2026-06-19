import SwiftUI
import AVFoundation

struct BreakSessionView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var isPresented: Bool
    let initialSeconds: Int
    var onContinue: () -> Void

    @State private var remainingSeconds = 300
    @State private var timer: Timer?
    
    @State private var audioPlayer: AVAudioPlayer?

    var formattedTime: String {
        let hours = remainingSeconds / 3600
        let minutes = (remainingSeconds % 3600) / 60
        let seconds = remainingSeconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }

    var body: some View {
        ZStack {
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            FishAnimationView(refreshFish: .constant(false))

            VStack {
                Text(formattedTime)
                    .font(Font.custom("Slackey-Regular", size: 53))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)

                Spacer()
                    .frame(height: 70)

                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    timer?.invalidate()
                    isPresented = false   // tutup modal
                    onContinue()
                }) {
                    ZStack{
                        Image("break_button")
                            .resizable()
                            .frame(width: 300, height: 70)
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                            .offset(y:10)
                        Text("FINISH BREAK")
                            .font(Font.custom("Slackey-Regular", size: 29))
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                            .offset(y:6)
                    }
                }
            }

//            if showBreakModal {
//                BreakConfirmation(isPresented: $showBreakModal, totalSeconds: initialSeconds, RemainingSeconds: remainingSeconds)
//            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            startTimer()
            playSound()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if remainingSeconds > 0 {
                remainingSeconds -= 1
            } else {
                timer?.invalidate()
                // Timer selesai
            }
        }
    }
    
    private func playSound() {
        if let soundURL = Bundle.main.url(forResource: "start_sound", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Gagal memutar audio: \(error.localizedDescription)")
            }
        }
    }
}

