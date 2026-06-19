import SwiftUI

struct PreparationModalView: View {
    @Binding var isPresented: Bool
    var totalSeconds: Int
    
    @State private var isChecklist1Checked = false
    @State private var isChecklist2Checked = false
    @State private var isChecklist3Checked = false
    
    @State private var modalConfirmation = false
    @State private var SessionSkipped = false
    
    
    var formattedTime: String {
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }

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
                    .frame(width: 322, height: 430)
                
                // light brown background
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .fill(Color(#colorLiteral(red: 1, green: 0.940058589, blue: 0.7803176045, alpha: 1)))
                    .frame(width: 295, height: 380)
                    .shadow(color: .black.opacity(0.5), radius: 5)
                
                // modal title
                ZStack{
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(Color(#colorLiteral(red: 0.9402096868, green: 0.3534892797, blue: 0.3253774941, alpha: 1)))
                        .frame(width: 220, height: 50)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    
                    Text("PREPARATION")
                        .font(Font.custom("Slackey-Regular", size: 23))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 5, x: 5)
                    
                }
                .offset(y: -200)
                
                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    isPresented = false
                }) {
                    Image("red_back_button")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .padding()
                }
                .position(x: 350, y: 240)
                
                // study time
                VStack{
                    Text("STUDY TIME")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    
                    ZStack{
                        RoundedRectangle(cornerRadius:15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 220, height: 42)
                        
                        Text(formattedTime)
                            .font(Font.custom("Slackey-Regular", size: 29))
                            .fontWeight(.bold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    }
                }
                .offset(y: -120)
                
                // checklist
                VStack(alignment: .leading, spacing: 15) {
                    
                    // checklist 1
                    HStack {
                        Text("Is the lighting good enough?")
                            .foregroundStyle(.brown)
                        Spacer()
                        Button(action: {
                            isChecklist1Checked.toggle()
                        }) {
                            Image(systemName: isChecklist1Checked ? "checkmark.square.fill" : "square")
                                .foregroundColor(.brown)
                                .font(.system(size: 22))
                        }
                    }
                    
                    // checklist 2
                    HStack {
                        Text("Are you sitting comfortably?")
                            .foregroundStyle(.brown)
                        Spacer()
                        Button(action: {
                            isChecklist2Checked.toggle()
                        }) {
                            Image(systemName: isChecklist2Checked ? "checkmark.square.fill" : "square")
                                .foregroundColor(.brown)
                                .font(.system(size: 22))
                        }
                    }
                    
                    // checklist 3
                    HStack {
                        Text("Is your environment distraction-free?")
                            .foregroundStyle(.brown)
                        Spacer()
                        Button(action: {
                            isChecklist3Checked.toggle()
                        }) {
                            Image(systemName: isChecklist3Checked ? "checkmark.square.fill" : "square")
                                .foregroundColor(.brown)
                                .font(.system(size: 22))
                        }
                    }
                    
                    Button(action: {
//                        AudioHelper.playSound(named: "bubble_sfx")
                        if isChecklist1Checked && isChecklist2Checked && isChecklist3Checked {
                            SessionSkipped = true
                        } else {
                            modalConfirmation = true
                        }
                    }) {
                        // start timer button
                        ZStack {
                            Image("button_confirmation")
                                .resizable()
                                .frame(width: 160, height: 42)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                            Text("START TIMER")
                                .font(Font.custom("Slackey-Regular", size: 16))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .offset(x:0, y:-3)
                        }
                        .padding(.leading, 40)
                        .padding(.top, 10)
                    }
                    
                } // end of checklist
                .font(Font.custom("Slackey-Regular", size: 14))
                .padding(.top, 120)
                .padding(.horizontal, 80)
        } // end of preparation modal
            if SessionSkipped {
                FocusSessionView(isPresented: $SessionSkipped, totalSeconds: totalSeconds)
            }
            if modalConfirmation {
                ConfirmationModalView(isPresented: $modalConfirmation, totalSeconds: totalSeconds)
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }
}

#Preview {
    PreparationModalView(isPresented: .constant(true), totalSeconds: 200)
}
