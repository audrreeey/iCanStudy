import SwiftData

struct CoinControl{
    
    static func addCoins(context: ModelContext, amount: Int) {
            if let user = try? context.fetch(FetchDescriptor<User>()).first {
                user.coins += amount
            } else {
                context.insert(User(coins: amount))
            }
            try? context.save()
    }
    
    static func rewardCoins(forSeconds userTotalSeconds: Int, context: ModelContext) {
            let coinAmount = userTotalSeconds / 300
            if coinAmount > 0 {
                addCoins(context: context, amount: coinAmount)
            }
    }
    
    static func calcCoins(forSeconds userTotalSeconds: Int) -> Int {
            let coinAmount = userTotalSeconds  / 300
            return coinAmount
    }
    
    static func removeCoins(context: ModelContext, amount: Int) {
            if let user = try? context.fetch(FetchDescriptor<User>()).first {
                if user.coins >= amount {
                    user.coins -= amount
                } else {
                    user.coins = 0 // Jika koin kurang dari yang akan dikurangi, set ke 0
                }
                try? context.save()
            }
        }
    
}
