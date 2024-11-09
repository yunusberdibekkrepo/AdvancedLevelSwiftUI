//
//  String+Extension.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 2.01.2024.
//

import Foundation

func randomString(lenght: Int = 8) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0 ... lenght).map { _ in
        letters.randomElement()!
    })
}
