//
//  ModalCoin.swift
//  IcanStudy
//
//  Created by Mac on 11/08/25.
//

import SwiftUI

struct ModalCoin: View {
    @Binding var showCoinModal:Bool
    
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
                    Spacer()
                    Text("Study Time Converter")
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                        .multilineTextAlignment(.center)
                        .bold()
                        .frame(width: 250)
                        .font(Font.custom("Slackey-Regular", size: 17, ))
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 240, height: 62)

                        HStack {
                            
                            Text("5 Min Study  =  1 ")
                                .font(Font.custom("Slackey-Regular", size: 17))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                                .padding(.leading,-10)
                            Image("Seashell")
                                .offset(x: -10,y: 2)
                        }.offset(x: 14)
                    }
                    .offset(y: -15)
                    Spacer()
                }
                .offset(y: 0)
                
                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    showCoinModal = false
                }) {
                    Image("red_back_button")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .padding()
                }
                .position(x: 340, y:340)
                
            }
                
            }
        }


#Preview {
    ModalCoin(showCoinModal: .constant(true))
}
