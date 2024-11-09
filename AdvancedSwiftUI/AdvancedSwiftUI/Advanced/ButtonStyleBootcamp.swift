//
//  ButtonStyleBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.11.2023.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat

    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .brightness(configuration.isPressed ? 0.1 : 0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    func withPressableButtonStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        Button(action: {}, label: {
            Text("Click me")
                .withDefaultButtonFormatting()
        })
        .withPressableButtonStyle(scaledAmount: 0.9)
        .padding(40)
    }
}

#Preview {
    ButtonStyleBootcamp()
}
