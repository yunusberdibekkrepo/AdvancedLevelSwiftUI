//
//  RotationGestureBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 10.01.2024.
//

import SwiftUI

struct RotationGestureBootcamp: View {
    @State var angle: Angle = .degrees(.zero)

    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(50)
            .background(.blue)
            .clipShape(.capsule)
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged { value in
                        angle = value
                    }
                    .onEnded { _ in
                        withAnimation(.spring) {
                            angle = .degrees(.zero)
                        }
                    }
            )
    }
}

#Preview {
    RotationGestureBootcamp()
}
