//
//  MagnificationGestureBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 9.01.2024.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State var currentAmount: CGFloat = .zero
    @State var lastAmount: CGFloat = .zero

    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(40)
            .background(.red)
            .clipShape(.capsule)
            .scaleEffect(1 + currentAmount + lastAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value
                    }
                    .onEnded { _ in
                        lastAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

#Preview {
    MagnificationGestureBootcamp()
}
