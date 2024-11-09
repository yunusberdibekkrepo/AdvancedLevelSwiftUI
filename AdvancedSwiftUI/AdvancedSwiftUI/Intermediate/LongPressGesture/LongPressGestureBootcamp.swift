//
//  LongPressGestureBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 8.01.2024.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isCompleted: Bool = false

    var body: some View {
        Text(isCompleted ? "Completed" : "Not completed")
            .padding()
            .padding(.horizontal)
            .background(isCompleted ? .green : .red)
            .foregroundStyle(.white)
            .clipShape(.capsule)
            // Minimum duration: En az x sn basılı tutmamız lazım. MaximumDistance: Tıkladıktan sonra parmağı x point götürmemizi sağlar. Mesela tıklanmanın zor olduğu yerlerde kullanınılır.
            .onLongPressGesture(minimumDuration: 1, maximumDistance: 5) {
                isCompleted.toggle()
            }
//            .onTapGesture {
//                isCompleted.toggle()
//            }
    }
}

#Preview {
    LongPressGestureBootcamp()
}
