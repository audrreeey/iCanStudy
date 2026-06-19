import SwiftUI
import SwiftData

struct ShopItem: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let price: Int
}
var currentFishNames = FishStorageManager.getFishNames()

struct ShopmodalView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query private var users: [User]

    @State var showmodal = false
    @State var showSeashellAnimation = false
    
    let items: [ShopItem] = [
        ShopItem(name: "Cute Nemo", imageName: "f1", price: 28),
        ShopItem(name: "Brave Turtle", imageName: "f2", price: 28),
        ShopItem(name: "Humble Shark", imageName: "f3", price: 22),
        ShopItem(name: "Shy Dory", imageName: "f4", price: 26),
        ShopItem(name: "Mrs. Pufferfish", imageName: "f5", price: 28),
        ShopItem(name: "Cartoon Fish", imageName: "f6", price: 21),
        ShopItem(name: "Lazy Seal", imageName: "f7", price: 43),
        ShopItem(name: "Pinky Fishy", imageName: "f8", price: 27),
        ShopItem(name: "Shiny Swordfish", imageName: "f9", price: 48),
        ShopItem(name: "Dr. Octopus", imageName: "f10", price: 63),
        ShopItem(name: "Mr. Crab", imageName: "f11", price: 55),
        ShopItem(name: "Patrickk", imageName: "f12", price: 25),
        ShopItem(name: "Octopuster", imageName: "f13", price: 23),
        ShopItem(name: "Healer Orca", imageName: "f14", price: 29),
        ShopItem(name: "Female Seahorse", imageName: "f15", price: 38),
        ShopItem(name: "Angler Fish", imageName: "f16", price: 55),
        ShopItem(name: "Puffy Brother", imageName: "f17", price: 34),
        ShopItem(name: "Male Seahorse", imageName: "f18", price: 30)
    ]

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    @State private var selectedItem: ShopItem? = nil

//    var onItemSelected: () -> Void
    @Binding var showShopModal:Bool
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .blur(radius: 10)

            ZStack {
                ZStack {
                    Image("coins_indicator")
                        .resizable()
                    Text("\(users.first?.coins ?? 0)")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .padding(.leading, 40)
                        .foregroundStyle(.coin)
                        .opacity(0.7)
                }
                .frame(width: 129, height: 52)
                .padding(.top, -370)
                .padding(.leading, 250)
                
                if showSeashellAnimation {
                   SeashellAnimationView(
                       endPoint: CGPoint(x: 200, y: UIScreen.main.bounds.height - 600)
                   ) {
                       showSeashellAnimation = false
                       
                       // 2️⃣ Setelah seashell animasi selesai, delay sedikit sebelum munculkan FishEnterAnimation
                       DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                           
                       }
                   }
                }


                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 0.792, green: 0.573, blue: 0.316, alpha: 1)))
                    .frame(width: 342, height: 460)

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 1, green: 0.94, blue: 0.78, alpha: 1)))
                    .frame(width: 320, height: 440)
                    .shadow(color: .black.opacity(0.5), radius: 5)

                VStack {
                    
                    
                    ZStack {
                        
                            
                            RoundedRectangle(cornerRadius: 15.0)
                                .fill(Color(#colorLiteral(red: 0.94, green: 0.35, blue: 0.32, alpha: 1)))
                                .frame(width: 160, height: 50)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                            
                            Text("SHOP")
                                .font(Font.custom("Slackey-Regular", size: 33))
                                .fontWeight(.bold)
                                .foregroundStyle(Color.white)
                                .shadow(radius: 5, x: 5)
                        
                        
                        
                        
                        Button(action: {
                            AudioHelper.playSound(named: "bubble_sfx")
                            showShopModal = false
                        }) {
                            Image("red_back_button")
                                .resizable()
                                .frame(width: 69, height: 69)
                                .padding()
                        }
                        .position(x: 300, y: 180)
                    }
                    .position(x:150, y: 125)
                    

                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 15) {
                            ForEach(items) { item in
                                VStack(spacing: 5) {
                                    Image(item.imageName)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 70, height: 60)
                                        .background(Color.white.opacity(0.7))
                                        .clipShape(RoundedRectangle(cornerRadius: 10))

                                    Button(action: {
//                                        AudioHelper.playSound(named: "bubble_sfx")
                                        selectedItem = item
                                    }) {
                                        HStack(spacing: 4) {
                                            Image("Seashell")
                                                .resizable()
                                                .frame(width: 20, height: 22)
                                                .offset(y:2)
                                            Text("\(item.price)")
                                                .font(Font.custom("Slackey-Regular", size: 15))
                                                .offset(x:-5)
                                        }
                                        .padding(5)
                                        .frame(maxWidth: .infinity)
                                        .background(Color(#colorLiteral(red: 0.3064529896, green: 0.3657993078, blue: 0.8219793439, alpha: 1)))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                    }
                                }
                                .padding(5)
                                .background(Color.yellow.opacity(0.3))
                                .cornerRadius(12)
                                .shadow(radius: 2)
                            }
                        }
                        .padding()
                    }
                    .scrollIndicators(.visible)
                    .position(x:150, y: 10)

                    
                }
                .frame(width: 300, height: 685)
            }
            
            
            if let selectedItem = selectedItem {
                ConfirmationModalViews(
                    item: selectedItem,
                    onConfirm: {
//                        onItemSelected?(selectedItem)
                        print("Confirmed purchase of: \(selectedItem.name)")
                        currentFishNames.append(selectedItem.imageName)
                        FishStorageManager.saveFishNames(currentFishNames)
                        print(FishStorageManager.getFishNames())
                        CoinControl.removeCoins(context: context, amount: selectedItem.price)
                        print("berhasil dikurang \(selectedItem.price)")
                        self.selectedItem = nil
                        showSeashellAnimation = true
//                        onItemSelected(selectedItem)
//                        onItemSelected()
                    },
                    onCancel: { i in
                        if i == "cancel"{
                            print("ini \(i)")
                            self.selectedItem = nil
                        }
                        else if i == "no money"{
                            print("ini \(i)")
                            self.selectedItem = nil
                            showmodal = true
                        }
                    },
                    
                )
            }
            
            if showmodal {
                NoMoneyShop(onQuit:{
                    showmodal = false
                    print("keluar dri nomoney")
                    
                })
            }

        }
    }
}

struct ShopmodalView_Previews: PreviewProvider {
    static var previews: some View {
//        ShopmodalView(onItemSelected: { item in
//            print("Confirmed purchase m k  of: \(item.name)")
//            currentFishNames.append("\(item.name)")
//            FishStorageManager.saveFishNames(currentFishNames)
//            print(FishStorageManager.getFishNames())
//            
//        })
        ShopmodalView (showShopModal: .constant(true))
    }
}

#Preview{
    ShopmodalView(showShopModal: .constant(true))
}


