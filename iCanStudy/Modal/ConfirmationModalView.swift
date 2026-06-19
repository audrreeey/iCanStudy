import SwiftUI

struct ConfirmationModalView: View {
    @Binding var isPresented: Bool
    var totalSeconds: Int
    
    @State private var focusSession = false

    var body: some View {
        ZStack {
            
            // background blur
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .blur(radius: 10)
            
            // modal preparation
            ZStack{
                
                // dark brown background
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color(#colorLiteral(red: 0.7920315862, green: 0.5732310414, blue: 0.3168769479, alpha: 1)))
                    .frame(width: 339, height: 250)
                
                // light brown background
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color(#colorLiteral(red: 1, green: 0.940058589, blue: 0.7803176045, alpha: 1)))
                    .frame(width: 318, height: 232)
                    .shadow(color: .black.opacity(0.5), radius: 5)
                }
            
                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    isPresented = false
                }) {
                    Image("red_back_button")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .padding()
                }
                .position(x: 350, y: 340)
                
                // study time
                VStack{
                    Text("You haven't checked all \n the boxes. Are you sure \n you want to continue?")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    
                    Button(action: {
//                        AudioHelper.playSound(named: "bubble_sfx")
                        focusSession = true
                    }) {
                        // start timer button
                        ZStack {
                            Image("button_confirmation")
                                .resizable()
                                .frame(width: 160, height: 42)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                            Text("CONFIRM")
                                .font(Font.custom("Slackey-Regular", size: 16))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .offset(x:0, y:-3)
                        }
                        .padding(.top, 10)
                    }
                }
                .frame(width: 270)
                .multilineTextAlignment(.center)
                .padding(.top, 20)
                
            if focusSession {
                FocusSessionView(isPresented: $focusSession, totalSeconds: totalSeconds)
            }
                    
        } // end of preparation modal
        
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }
}
#Preview {
    ConfirmationModalView(isPresented: .constant(true), totalSeconds: 200)
}
