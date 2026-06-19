import SwiftUI

struct DummySeashell: Identifiable {
    let id = UUID()
    var position: CGPoint
}

struct SeashellAnimationView: View {
    let shellCount = 7 // Total kerang yang akan keluar
    let endPoint: CGPoint
    let onAnimationFinished: () -> Void

    @State private var shells: [DummySeashell] = []

    var body: some View {
        ZStack {
            ForEach(shells) { shell in
                Image("Seashell")
                    .resizable()
                    .frame(width: 50, height: 50) // ✅ Ukuran diperbesar
                    .position(shell.position)
                    .transition(.opacity)
            }
        }
        .onAppear {
            startShellAnimation()
        }
    }

    func startShellAnimation() {
        for i in 0..<shellCount {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.1) {
                
                let startX = UIScreen.main.bounds.width - 60
                let startY = 80.0
                let shell = DummySeashell(position: CGPoint(x: startX, y: startY))
                // ✅ Posisi awal di sekitar coins_indicator (pojok kanan atas)
                
                shells.append(shell)

                withAnimation(.easeInOut(duration: 0.5)) {
                    if let index = shells.firstIndex(where: { $0.id == shell.id }) {
                        shells[index].position = endPoint
                    }
                }

                // Hapus shell setelah selesai animasi
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    shells.removeAll { $0.id == shell.id }

                    if i == shellCount - 1 {
                        onAnimationFinished()
                    }
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.blue.opacity(0.3).ignoresSafeArea()

        SeashellAnimationView(
            endPoint: CGPoint(x: 200, y: UIScreen.main.bounds.height - 700)
        ) {
            print("Semua kerang selesai.")
        }
    }
}
