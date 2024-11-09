//
//  AnyTransitionBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.11.2023.
//

import SwiftUI

struct RotateViewModifier: ViewModifier {
    let rotation: Double

    func body(content: Content) -> some View {
        content
            .rotationEffect(Angle(degrees: rotation))
            .offset(
                x: rotation != 0 ? UIScreen.main.bounds.width : 0,
                y: rotation != 0 ? UIScreen.main.bounds.height : 0)
    }
}

extension AnyTransition {
    static var rotating: AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: 180),
            identity: RotateViewModifier(rotation: 0))
    }

    static var rotateOn: AnyTransition {
        asymmetric(
            insertion: .rotating,
            removal: .move(edge: .leading))
    }

    static func rotating(rotation: Double) -> AnyTransition {
        modifier(
            active: RotateViewModifier(rotation: rotation),
            identity: RotateViewModifier(rotation: 0))
    }
}

struct AnyTransitionBootcamp: View {
    @State private var showRectangle: Bool = false

    var body: some View {
        VStack(content: {
            Spacer()

            if showRectangle {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 250, height: 350)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .transition(.rotateOn)
                    //.transition(.rotating)
            }

            Spacer()

            Text("Click Me!")
                .withDefaultButtonFormatting()
                .padding(.horizontal, 24)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showRectangle.toggle()
                    }
                }
        }) // VStack
    }
}

#Preview {
    AnyTransitionBootcamp()
}

/*
 SwiftUI'deki asymmetric fonksiyonu, asimetrik bir geçiş tanımlamak için kullanılır. Genellikle, bir görünümün eklenmesi (insertion) ve bir görünümün kaldırılması (removal) durumlarında farklı geçiş efektleri uygulamak için kullanılır. asymmetric fonksiyonu, bu iki durumu belirtmek için iki farklı geçiş efekti alır.
 */
