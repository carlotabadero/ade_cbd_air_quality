import SwiftUI

struct ContentView: View {
    @State private var die1 = 1
    @State private var die2 = 1
    @State private var isRolling = false
    @State private var spin = 0.0

    private var total: Int { die1 + die2 }

    var body: some View {
        ZStack {
            // Green "felt" table background.
            LinearGradient(
                colors: [Color(red: 0.05, green: 0.35, blue: 0.20),
                         Color(red: 0.02, green: 0.22, blue: 0.13)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 40) {
                Text("Dice Roller")
                    .font(.system(size: 34, weight: .heavy, design: .rounded))
                    .foregroundStyle(.white)
                    .shadow(color: .black.opacity(0.4), radius: 2, y: 2)

                HStack(spacing: 28) {
                    DieView(value: die1)
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(spin))
                    DieView(value: die2)
                        .frame(width: 120, height: 120)
                        .rotationEffect(.degrees(-spin))
                }

                VStack(spacing: 4) {
                    Text("TOTAL")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(.white.opacity(0.7))
                        .tracking(2)
                    Text("\(total)")
                        .font(.system(size: 56, weight: .black, design: .rounded))
                        .foregroundStyle(.white)
                        .contentTransition(.numericText())
                }

                Button(action: roll) {
                    Text(isRolling ? "Rolling…" : "Roll")
                        .font(.system(size: 22, weight: .bold, design: .rounded))
                        .foregroundStyle(Color(red: 0.02, green: 0.22, blue: 0.13))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            Capsule().fill(.white)
                        )
                        .shadow(color: .black.opacity(0.3), radius: 6, y: 4)
                }
                .padding(.horizontal, 60)
                .disabled(isRolling)
            }
            .padding()
        }
        // Shake the phone to roll.
        .onShake { roll() }
    }

    private func roll() {
        guard !isRolling else { return }
        isRolling = true

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()

        // Quick "tumble" animation: flash a few random faces, then settle.
        var ticks = 0
        let maxTicks = 8
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.06)) {
                die1 = Int.random(in: 1...6)
                die2 = Int.random(in: 1...6)
                spin += 45
            }
            ticks += 1
            if ticks >= maxTicks {
                timer.invalidate()
                withAnimation(.spring(response: 0.35, dampingFraction: 0.6)) {
                    die1 = Int.random(in: 1...6)
                    die2 = Int.random(in: 1...6)
                    spin = 0
                }
                UINotificationFeedbackGenerator().notificationOccurred(.success)
                isRolling = false
            }
        }
    }
}

#Preview {
    ContentView()
}
