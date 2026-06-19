import SwiftUI
import SwiftData

@main
struct ICanStudy: App {
    
    @AppStorage("hasLaunchedBefore") private var hasLaunchedBefore: Bool = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if hasLaunchedBefore {
                    HomeView() // Halaman utama
                } else {
                    WelcomeView() // Halaman perkenalan
                }
            }
        }
        .modelContainer(for: [User.self, StudySession.self])
    }
}
