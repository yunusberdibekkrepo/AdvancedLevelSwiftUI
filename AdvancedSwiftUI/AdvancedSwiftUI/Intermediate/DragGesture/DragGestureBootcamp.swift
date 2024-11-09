//
//  DragGestureBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 10.01.2024.
//

import SwiftUI

struct DragGestureBootcamp: View {
    @State var offset: CGSize = .zero

    var body: some View {
        ZStack {
            VStack(content: {
                Text(offset.width.description)
                Spacer()
            })
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaledAmount())
                .rotationEffect(.degrees(getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring) {
                                offset = value.translation
                            }
                        }
                        .onEnded { _ in
                            withAnimation(.spring) {
                                offset = .zero
                            }
                        }
                )
        }
    }

    private func getScaledAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        return 1.0 - min(percentage, 0.5) * 0.5
    }

    private func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.height / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        return percentageAsDouble * maxAngle
    }
}

#Preview {
    DragGestureBootcamp()
}
