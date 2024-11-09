//
//  ProtocolsBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    var primary: Color = .blue
    var secondary: Color = .red
    var tertiary: Color = .purple
}

protocol ColorThemeProtocol {
    var primary: Color { get }
    var secondary: Color { get }
    var tertiary: Color { get }
}

final class DefaultDataSource: ButtonDataSourceProtocol {
    func buttonPressed() {
        print("Default data source button pressed.")
    }

    var buttonText: String = "Protocols are awesome."
}

final class AlternativeDataSource: ButtonTextProtocol {
    func buttonPressed() {
        print("Alternative data source button pressed.")
    }

    var buttonText: String = "Protocols are lame."
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol {}

struct ProtocolsBootcamp: View {
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol

    var body: some View {
        ZStack {
            colorTheme.tertiary
                .ignoresSafeArea()
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .clipShape(.rect(cornerRadius: 10))
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(
        colorTheme: DefaultColorTheme(),
        dataSource: DefaultDataSource())
}
