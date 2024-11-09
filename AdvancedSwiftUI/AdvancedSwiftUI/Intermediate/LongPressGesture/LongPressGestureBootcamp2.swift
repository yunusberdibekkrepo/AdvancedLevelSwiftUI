//
//  LongPressGestureBootcamp2.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 9.01.2024.
//

import SwiftUI

struct LongPressGestureBootcamp2: View {
    @State var isPressing: Bool = false
    @State var isAnimating: Bool = false

    var body: some View {
        VStack(content: {
            Circle()
                .trim(from: isAnimating ? 0 : 1, to: 1)
                .stroke(isPressing ? .green : .black, lineWidth: 20)

            Text("Tıkla")
                .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) {
                    // Perform
                    // 1sn basıldıktan sonraJest  çalışacak kısım.
                    withAnimation {
                        isPressing = true
                    }
                } onPressingChanged: { isPressing in
                    // Kullanıcı basma işlemini gerçekleştirdiği sürece çalışır. Daha sonra perform içine girer.
                    if isPressing {
                        withAnimation(.easeInOut(duration: 1)) {
                            isAnimating.toggle()
                        }
                    } else {
                        withAnimation(.easeInOut(duration: 1)) {
                            isAnimating = false
                        }
                    }
                }
        })
    }
}

#Preview {
    LongPressGestureBootcamp2()
}

/*
 var body: some View {
     VStack(content: {
         Circle()
             .trim(from: isAnimating ? 0 : 1, to: 1)
             .stroke(.blue, lineWidth: 20)
             .animation(.easeInOut(duration: 1).repeatForever(), value: isAnimating)
     })
     .onAppear {
         isAnimating = true
     }
 }
 */
