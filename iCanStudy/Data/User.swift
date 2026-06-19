import Foundation
import SwiftData

@Model
class User {
    var coins: Int
    
    init(coins: Int) {
        self.coins = coins
    }
}
