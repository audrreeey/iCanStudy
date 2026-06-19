import SwiftUI
import SwiftData

struct ConfirmationModalViews: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @Query private var users: [User]
    
    let item: ShopItem
    let onConfirm: () -> Void
    let onCancel: (_ message:String) -> Void
    
    var body: some View {
        
        
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()

            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(#colorLiteral(red: 0.792, green: 0.573, blue: 0.316, alpha: 1)))
                .frame(width: 302, height: 300)

            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(#colorLiteral(red: 1, green: 0.94, blue: 0.78, alpha: 1)))
                .frame(width: 280, height: 280)
                .shadow(color: .black.opacity(0.5), radius: 5)
            
            Button(action: {
                            onCancel("cancel")
                        }) {
                            Image("red_back_button")
                                .resizable()
                                .frame(width: 69, height: 69)
                                .padding()
                                .position(x: 340, y: 300)
            }
            
            VStack(spacing: 20) {

                Image(item.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                 
                    .clipShape(RoundedRectangle(cornerRadius: 15))

                Text("Buy \(item.name) for \n \(item.price) coins?")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .frame(width:300)
                    .font(Font.custom("Slackey-Regular", size: 15))
                    .offset(x:0, y:-10)
                    .foregroundStyle(Color.black)

                    Button("Buy") {
                            
                            if let coin = users.first?.coins {
                                print("User has \(coin) coins")
                                if coin >= item.price {
                                    AudioHelper.playSound(named: "coinsdrop_sfx")
                                    onConfirm()
                                } else {
                                    // Not enough coins
                                    onCancel("no money")
                                    print("Insufficient coins")
                                }
                            }
                            
                        else {
                            // Not enough coins
                            onCancel("no money")
                            print("Insufficient coins")
                        }
                        }
                        .frame(width: 100, height: 40)
                        .background(Color(#colorLiteral(red: 0.3064529896, green: 0.3657993078, blue: 0.8219793439, alpha: 1)))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .font(Font.custom("Slackey-Regular", size: 15))
                    .padding()
                    .frame(width: 100,height: 40)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .offset(y: -10)
            }
            .padding()
            .frame(width: 300)
            

        }
    }
}


