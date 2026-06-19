import SwiftUI

struct Fish: Identifiable {
    let id = UUID()
    var position: CGPoint
    var movingRight: Bool
    var movingUp: Bool
    let imageName: String
    var baseY: CGFloat
    var isChasingFood: Bool = false
    var targetFoodID: UUID? = nil
    var speed: CGFloat
    var randomMoveTimer: TimeInterval = 0
    var reactionTime: TimeInterval
    var reactionCounter: TimeInterval = 0
    var idleTimer: TimeInterval = 0
}

struct Food: Identifiable {
    let id = UUID()
    var position: CGPoint
    var sinkSpeed: CGFloat
}

struct FishAnimationView: View {
    @State private var fishes: [Fish] = []
    @State private var foods: [Food] = []
    @State private var timer: Timer?
    @State private var wigglePhase: CGFloat = 0
    @Binding var refreshFish: Bool
    @State var fishImages = FishStorageManager.getFishNames()
    
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let horizontalBaseSpeed: CGFloat = 0.15
    let verticalBaseSpeed: CGFloat = 0.20
    let verticalTopLimit: CGFloat = -100
    let verticalBottomLimit: CGFloat = UIScreen.main.bounds.height + 20
    
    var body: some View {
        ZStack {
            ForEach(foods) { food in
                Circle()
                    .fill(.food)
                    .frame(width: 5, height: 5)
                    .position(food.position)
            }
            
            ForEach(fishes) { fish in
                Image(fish.imageName)
                    .resizable()
                    .frame(width: 60, height: 50)
                    .scaleEffect(x: fish.movingRight ? 1 : -1, y: 1)
                    .position(
                        x: fish.position.x,
                        y: fish.position.y + sin(wigglePhase + CGFloat(fish.id.hashValue % 100) / 20) * 5
                    )
            }
        }
        .contentShape(Rectangle())
        .onTapGesture { location in
            let food = Food(
                position: CGPoint(x: location.x, y: 50),
                sinkSpeed: CGFloat.random(in: 0.2...0.6)
            )
            foods.append(food)
        }
        .onAppear {
            fishImages = FishStorageManager.getFishNames()
            createFishes()
            startSwimming()
        }
        .onChange(of: refreshFish) { _, _ in
            fishImages = FishStorageManager.getFishNames()
            createFishes()
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
    
    func createFishes() {
        var tempFishes: [Fish] = []
        
        for index in 0..<fishImages.count {
            let x = CGFloat.random(in: 50...(screenWidth - 50))
            let y = CGFloat.random(in: verticalTopLimit...verticalBottomLimit)
            let speed = CGFloat.random(in: 0.4...0.9)
            let reaction = Double.random(in: 0.5...5.0)
            
            tempFishes.append(
                Fish(
                    position: CGPoint(x: x, y: y),
                    movingRight: Bool.random(),
                    movingUp: Bool.random(),
                    imageName: fishImages[index % fishImages.count],
                    baseY: y,
                    speed: speed,
                    randomMoveTimer: Double.random(in: 1...4),
                    reactionTime: reaction,
                    idleTimer: Double.random(in: 0...1)
                )
            )
        }
        
        fishes = tempFishes
    }
    
    func startSwimming() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0 / 60.0, repeats: true) { _ in
            wigglePhase += 0.1
            
            foods = foods.map { food in
                var f = food
                f.position.y += f.sinkSpeed
                return f
            }
            foods.removeAll { $0.position.y > screenHeight }
            
            fishes = fishes.map { fish in
                var newFish = fish
                
                if newFish.idleTimer > 0 {
                    newFish.idleTimer -= 1.0 / 60.0
                    return newFish
                }
                
                // 🚀 Kejar makanan
                if !foods.isEmpty {
                    if !newFish.isChasingFood {
                        newFish.reactionCounter += 1.0 / 60.0
                        if newFish.reactionCounter >= newFish.reactionTime {
                            if let nearest = foods.min(by: {
                                dist($0.position, newFish.position) < dist($1.position, newFish.position)
                            }) {
                                newFish.isChasingFood = true
                                newFish.targetFoodID = nearest.id
                                newFish.reactionCounter = 0
                            }
                        }
                    } else {
                        if let target = foods.first(where: { $0.id == newFish.targetFoodID }) {
                            let dx = target.position.x - newFish.position.x
                            let dy = target.position.y - newFish.position.y
                            let distance = sqrt(dx*dx + dy*dy)
                            if distance > 1 {
                                let stepX = (dx / distance) * (newFish.speed * 0.8)
                                let stepY = (dy / distance) * (newFish.speed * 0.8)
                                newFish.position.x += stepX
                                newFish.position.y += stepY
                                newFish.movingRight = stepX > 0
                            }
                            if distance < 15 {
                                foods.removeAll { $0.id == target.id }
                                newFish.isChasingFood = false
                                newFish.targetFoodID = nil
                                newFish.idleTimer = Double.random(in: 0.5...1.5)
                                
                                // 🎯 Setelah makan → condong ke bawah
                                newFish.movingUp = false
                            }
                        } else {
                            newFish.isChasingFood = false
                            newFish.targetFoodID = nil
                        }
                    }
                } else {
                    // 🐟 Random move (lebih suka turun)
                    newFish.reactionCounter = 0
                    newFish.isChasingFood = false
                    newFish.targetFoodID = nil
                    
                    newFish.randomMoveTimer -= 1.0 / 60.0
                    if newFish.randomMoveTimer <= 0 {
                        newFish.movingRight = Bool.random()
                        // 🎯 70% kemungkinan bergerak ke bawah
                        newFish.movingUp = Double.random(in: 0...1) > 0.525 ? true : false
                        newFish.randomMoveTimer = Double.random(in: 1...4)
                        if Bool.random() {
                            newFish.idleTimer = Double.random(in: 0.3...1.0)
                        }
                    }
                    
                    let frameSpeed = newFish.speed * CGFloat.random(in: 0.9...1.1)
                    let dx = (newFish.movingRight ? horizontalBaseSpeed : -horizontalBaseSpeed) * frameSpeed
                    let curveOffset = sin(wigglePhase / 5 + CGFloat(newFish.id.hashValue % 10)) * 0.3
                    let dy = (newFish.movingUp ? -verticalBaseSpeed : verticalBaseSpeed) * frameSpeed + curveOffset
                    
                    newFish.position.x = max(30, min(screenWidth - 30, newFish.position.x + dx))
                    newFish.position.y = max(verticalTopLimit, min(verticalBottomLimit, newFish.position.y + dy))
                }
                
                return newFish
            }
        }
    }
    
    func dist(_ a: CGPoint, _ b: CGPoint) -> CGFloat {
        let dx = a.x - b.x
        let dy = a.y - b.y
        return sqrt(dx*dx + dy*dy)
    }
}

#Preview {
    FishAnimationView(refreshFish: .constant(false))
}
