//
//  ViewModifierBootcampView.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 8.11.2023.
//

import SwiftUI

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack(content: {
            Text("Hello, World")
                .withDefaultButtonFormatting()

            Text("Hello, World")
                .withDefaultButtonFormatting(bacgroundColor: .orange)

            Text("Hello, World")
                .modifier(DefaultButtonViewModifier(backgroundColor: .red))

        }) // VStack
    }
}

extension View {
    func withDefaultButtonFormatting(bacgroundColor: Color = .blue) -> some View {
        return modifier(DefaultButtonViewModifier(backgroundColor: bacgroundColor))
    }
}

struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color

    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(radius: 10)
            .padding()
    }
}

#Preview {
    ViewModifierBootcamp()
}
