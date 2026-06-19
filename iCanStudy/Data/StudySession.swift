import Foundation
import SwiftData

@Model
class StudySession {
    var date: Date
    var studiedSeconds: Int

    init(date: Date, studiedSeconds: Int) {
        self.date = date
        self.studiedSeconds = studiedSeconds
    }
}
