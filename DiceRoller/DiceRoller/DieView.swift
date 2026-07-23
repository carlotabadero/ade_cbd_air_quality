import SwiftUI

/// A single die that draws its face as pips for the given value (1...6).
struct DieView: View {
    let value: Int

    // The pip layout for each face, described as a 3x3 grid of booleans.
    // Row-major: index 0 = top-left, index 8 = bottom-right.
    private static let layouts: [Int: [Bool]] = [
        1: [false, false, false,
            false, true,  false,
            false, false, false],
        2: [true,  false, false,
            false, false, false,
            false, false, true],
        3: [true,  false, false,
            false, true,  false,
            false, false, true],
        4: [true,  false, true,
            false, false, false,
            true,  false, true],
        5: [true,  false, true,
            false, true,  false,
            true,  false, true],
        6: [true,  false, true,
            true,  false, true,
            true,  false, true]
    ]

    var body: some View {
        GeometryReader { geo in
            let side = min(geo.size.width, geo.size.height)
            let pip = side * 0.16
            let layout = Self.layouts[value] ?? Self.layouts[1]!

            RoundedRectangle(cornerRadius: side * 0.18, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [Color.white, Color(white: 0.92)],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(
                    RoundedRectangle(cornerRadius: side * 0.18, style: .continuous)
                        .stroke(Color.black.opacity(0.08), lineWidth: 1)
                )
                .overlay(pips(layout: layout, pip: pip, side: side))
                .shadow(color: .black.opacity(0.25), radius: side * 0.06, x: 0, y: side * 0.04)
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private func pips(layout: [Bool], pip: CGFloat, side: CGFloat) -> some View {
        // Inset the 3x3 grid so pips sit nicely within the die face.
        let inset = side * 0.22
        let usable = side - inset * 2
        let step = usable / 2

        return ForEach(0..<9, id: \.self) { index in
            if layout[index] {
                let col = CGFloat(index % 3)
                let row = CGFloat(index / 3)
                Circle()
                    .fill(Color(red: 0.12, green: 0.12, blue: 0.14))
                    .frame(width: pip, height: pip)
                    .position(
                        x: inset + col * step,
                        y: inset + row * step
                    )
            }
        }
    }
}

#Preview {
    HStack {
        ForEach(1...6, id: \.self) { v in
            DieView(value: v).frame(width: 60, height: 60)
        }
    }
    .padding()
    .background(Color.green)
}
