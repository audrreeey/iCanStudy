import SwiftUI
import SwiftData

struct StreakModalView: View {
    @Environment(\.modelContext) private var context
    @Binding var isPresented: Bool

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .blur(radius: 10)

            ZStack {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 0.7920315862, green: 0.5732310414, blue: 0.3168769479, alpha: 1)))
                    .frame(width: 332, height: 352)

                RoundedRectangle(cornerRadius: 25.0)
                    .fill(Color(#colorLiteral(red: 1, green: 0.940058589, blue: 0.7803176045, alpha: 1)))
                    .frame(width: 302, height: 319)
                    .shadow(color: .black.opacity(0.5), radius: 5)

                ZStack {
                    RoundedRectangle(cornerRadius: 5.0)
                        .fill(Color(#colorLiteral(red: 0.9135003686, green: 0.2600500882, blue: 0.2565283477, alpha: 1)))
                        .frame(width: 190, height: 50)
                        .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 6)
                    Text("STREAK")
                        .font(Font.custom("Slackey-Regular", size: 30))
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                        .shadow(radius: 5, x: 5)
                    
                }
                .offset(y: -170)
                
                Button(action: {
                    AudioHelper.playSound(named: "bubble_sfx")
                    isPresented = false
                }) {
                    Image("red_back_button")
                        .resizable()
                        .frame(width: 69, height: 69)
                        .padding()
                }
                .position(x: 350, y: 280)
                
                VStack {
                    Text("YOUR STREAK HOURS")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .fontWeight(.bold)
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))

                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 261, height: 42)

                        Text(StudySessionManager.getTotalTimeAll(context: context))
                            .font(Font.custom("Slackey-Regular", size: 33))
                            .fontWeight(.bold)
                            .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    }
                    .offset(y: -10)
                }
                .offset(y:-40)

                VStack {
                    Text("THAT WAS")
                        .font(Font.custom("Slackey-Regular", size: 15))
                        .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 15.0)
                            .fill(Color(#colorLiteral(red: 0.9668874145, green: 0.9050707221, blue: 0.7431390882, alpha: 1)))
                            .frame(width: 261, height: 42)

                            Text("0 FULL DAYS")
                                .font(Font.custom("Slackey-Regular", size: 29))
                                .fontWeight(.bold)
                                .foregroundStyle(Color(#colorLiteral(red: 0.7611408234, green: 0.5822563767, blue: 0.4629541636, alpha: 1)))
                                .padding(.leading,-10)
                    }
                    .offset(y: -10)
                }
                .offset(y: 55)
                
            }
        }
        .transition(.opacity)
        .animation(.easeInOut, value: isPresented)
    }
}

#Preview {
    StreakModalView(isPresented: .constant(true))
}
