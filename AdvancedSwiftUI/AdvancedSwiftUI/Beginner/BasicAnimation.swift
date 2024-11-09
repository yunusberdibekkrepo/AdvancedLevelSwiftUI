//
//  BasicAnimation.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 9.01.2024.
//

import SwiftUI

struct BasicAnimation: View {
    @State var isAnimating: Bool = false

    var body: some View {
        VStack(content: {
            Circle()
                .trim(from: isAnimating ? 0 : 1, to: 1)
                .stroke(.blue, lineWidth: 20)
                .animation(.easeInOut(duration: 1.5).repeatForever(), value: isAnimating)
        })
        .onAppear {
            isAnimating = true
        }
    }
}

#Preview {
    BasicAnimation()
}
