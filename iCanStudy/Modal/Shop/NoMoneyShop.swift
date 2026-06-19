//
//  NoMoneyShop.swift
//  IcanStudy
//
//  Created by Mac on 05/08/25.
//

import SwiftUI

struct NoMoneyShop: View {
    let onQuit: () -> Void
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .ignoresSafeArea()
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(#colorLiteral(red: 0.792, green: 0.573, blue: 0.316, alpha: 1)))
                .frame(width: 302, height: 180)
            
            RoundedRectangle(cornerRadius: 25.0)
                .fill(Color(#colorLiteral(red: 1, green: 0.94, blue: 0.78, alpha: 1)))
                .frame(width: 280, height: 160)
                .shadow(color: .black.opacity(0.5), radius: 5)
            
            VStack(spacing: 20) {
                Text("Oops! Sorry, You don’t\n have enough coins to \n buy this item.")
                    .multilineTextAlignment(.center)
                    .bold()
                    .frame(width: 250)
                    .font(Font.custom("Slackey-Regular", size: 17, ))
                    
            }
            
            Button(action: {
//                FishStorageManager.resetFishNames()
                AudioHelper.playSound(named: "bubble_sfx")
                onQuit()
            }) {
                Image("red_back_button")
                    .resizable()
                    .frame(width: 69, height: 69)
                    .padding()
            }
            .position(x: 340, y: 365)
        }
    }
}
#Preview {
    NoMoneyShop(onQuit: {
        print("HakunaMatata")
    })
}
