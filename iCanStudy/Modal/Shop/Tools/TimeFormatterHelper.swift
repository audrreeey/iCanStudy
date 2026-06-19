import Foundation

struct TimeFormatterHelper {
    static func formatTime(seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, remainingSeconds)
    }
}
