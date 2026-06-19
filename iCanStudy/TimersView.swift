import SwiftUI
import SwiftData

struct TimersView: View {
    @Environment(\.modelContext) private var context
    @Query private var users: [User]
    
    @State private var showPreparationModal = false
    @State private var selectedHour = 0
    @State private var selectedMinute = 0
    @State private var selectedSecond = 0
    @State private var selectedTotalSeconds = 0
    
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        ZStack {
            
            // background app
            Image("background_app")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
        
            
            Button(action: {
                AudioHelper.playSound(named: "bubble_sfx")
                dismiss()
            }) {
                Image("back_button")
                    .resizable()
                    .frame(width: 55, height: 55)
            }
            .offset(x: -150, y: -344)

            
            // coins indicator
            ZStack {
                Image("coins_indicator")
                    .resizable()
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                
                
                Text("\(users.first?.coins ?? 0)")
                    .font(Font.custom("Slackey-Regular", size: 15))
                    .foregroundStyle(.coin)
                    .opacity(0.7)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                
                    .padding(.leading, 40)
            }
            .frame(width: 129, height: 52)
            .padding(.top, -370)
            .padding(.leading, 250)
            
            // timer
            VStack(spacing: 10) {
                
                // timer title
                Text("Today's Study Time")
                    .font(Font.custom("Slackey-Regular", size: 25))
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    .offset(x:0, y:20)
                

                // timer picker
                HStack(spacing: 10) {
                    
                    // hours picker
                    Picker(selection: $selectedHour, label: Text("Hour")) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text(String(format: "%02d", hour))
                                .font(Font.custom("Slackey-Regular", size: 30))
                                .foregroundColor(.white)
                                .tag(hour)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 120)
                    .clipped()
                    
                    Text(":")
                        .font(Font.custom("Slackey-Regular", size: 30))
                        .foregroundColor(.white)
                    
                    // minutes picker
                    Picker(selection: $selectedMinute, label: Text("Minute")) {
                        ForEach(0..<60, id: \.self) { minute in
                            Text(String(format: "%02d", minute))
                                .font(Font.custom("Slackey-Regular", size: 30))
                                .foregroundColor(.white)
                                .tag(minute)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 120)
                    .clipped()
                    
                    Text(":")
                        .font(Font.custom("Slackey-Regular", size: 30))
                        .foregroundColor(.white)
                    
                    // second picker
                    Picker(selection: $selectedSecond, label: Text("Second")) {
                        ForEach(0..<60, id: \.self) { second in
                            Text(String(format: "%02d", second))
                                .font(Font.custom("Slackey-Regular", size: 30))
                                .foregroundColor(.white)
                                .tag(second)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 80, height: 120)
                    .clipped()
                }

                // start button
                Button(action: {
//                    AudioHelper.playSound(named: "bubble_sfx")
                    selectedTotalSeconds = selectedHour * 3600 + selectedMinute * 60 + selectedSecond
                    showPreparationModal = true
                }) {
                    GlowButtonView2()
                        .offset(x:0, y:20)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .offset(y: -100)
            
            // preparation modal
            if showPreparationModal {
                PreparationModalView(isPresented: $showPreparationModal, totalSeconds: selectedTotalSeconds)
            }
            
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    TimersView()
}
