import Foundation
import AVFoundation

class AudioHelper {
    static var audioPlayer: AVAudioPlayer?

    static func playSound(named fileName: String) {
        let possibleExtensions = ["mp3"] // daftar ekstensi yang didukung

        for ext in possibleExtensions {
            if let soundURL = Bundle.main.url(forResource: fileName, withExtension: ext) {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                    audioPlayer?.volume = 0.1
                    audioPlayer?.play()
                    return // berhenti setelah berhasil memutar
                } catch {
                    print("Gagal memutar audio: \(error.localizedDescription)")
                    return
                }
            }
        }
        print("File audio tidak ditemukan")
    }
}
