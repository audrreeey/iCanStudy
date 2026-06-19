import Foundation
import SwiftData

struct StudySessionManager {
    static func addSession(studiedSeconds: Int, context: ModelContext) {
        let newSession = StudySession(
            date: Date(),
            studiedSeconds: studiedSeconds
        )
        context.insert(newSession)
        
        do {
            try context.save()
            print("✅ Study session saved.")
        } catch {
            print("❌ Failed to save study session: \(error)")
        }
    }
    
    static func getFormattedTimeString(from seconds: Int) -> String {
            let hours = seconds / 3600
            let minutes = (seconds % 3600) / 60
            let secs = seconds % 60
            return String(format: "%02d : %02d : %02d", hours, minutes, secs)
        }
    
    static func getTotalTimeToday(context: ModelContext) -> String {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)!

            let descriptor = FetchDescriptor<StudySession>(
                predicate: #Predicate { $0.date >= today && $0.date < tomorrow }
            )
            
            do {
                let sessions = try context.fetch(descriptor)
                let totalSeconds = sessions.reduce(0) { $0 + $1.studiedSeconds }
                return getFormattedTimeString(from: totalSeconds)
            } catch {
                print("❌ Failed to fetch today's sessions: \(error)")
                return "00 : 00 : 00"
            }
        }
        
        static func getTotalTimeAll(context: ModelContext) -> String {
            let descriptor = FetchDescriptor<StudySession>()

            do {
                let sessions = try context.fetch(descriptor)
                let totalSeconds = sessions.reduce(0) { $0 + $1.studiedSeconds }
                return getFormattedTimeString(from: totalSeconds)
            } catch {
                print("❌ Failed to fetch all sessions: \(error)")
                return "00 : 00 : 00"
            }
        }
}
