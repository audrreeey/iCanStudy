import SwiftUI

struct SlideToConfirmButton: View {
    var onSlideComplete: () -> Void

    @State private var dragOffset: CGFloat = 0
    let barWidth: CGFloat = 270
    let barHeight: CGFloat = 34
    let handleWidth: CGFloat = 60

    var body: some View {
        ZStack(alignment: .leading) {
            // Base bar
            RoundedRectangle(cornerRadius: barHeight / 2)
                .fill(Color.gray.opacity(0.2))
                .frame(width: barWidth, height: barHeight)
            
            // Fill bar
            RoundedRectangle(cornerRadius: barHeight / 2)
                .fill(Color.red)
                .frame(width: dragOffset + handleWidth / 2, height: barHeight)
            
            // Text label
            HStack {
                Text("Slide to Confirm")
                    .font(Font.custom("Slackey-Regular", size: 13))                    .foregroundColor(.black.opacity(dragOffset > barWidth - handleWidth - 10 ? 0 : 0.6))
                    .frame(maxWidth: .infinity)
            }
            
            ZStack{
                
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.red)
                    .frame(width: handleWidth, height: barHeight)
                    .shadow(radius: 3)
                    .offset(x: dragOffset)
                
                Text(">>")    
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundColor(.gray)
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let newOffset = min(max(0, value.translation.width), barWidth - handleWidth)
                        dragOffset = newOffset
                    }
                    .onEnded { _ in
                        if dragOffset > barWidth - handleWidth - 10 {
                            onSlideComplete()
                        } else {
                            withAnimation(.easeOut) {
                                dragOffset = 0
                            }
                        }
                    }
            )
        }
        .frame(width: barWidth, height: barHeight)
    }
}

#Preview {
    SlideToConfirmButton {
        print("Slide confirmed")
    }
}
