//
//  TabBarItem.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import Foundation
import SwiftUI

enum TabBarItem: Hashable {
    case home, favorite, profile

    var iconName: String {
        switch self {
        case .home:
            "house"
        case .favorite:
            "heart"
        case .profile:
            "person"
        }
    }

    var title: String {
        switch self {
        case .home:
            "Home"
        case .favorite:
            "Favorites"
        case .profile:
            "Profile"
        }
    }

    var color: Color {
        switch self {
        case .home:
            .red
        case .favorite:
            .blue
        case .profile:
            .green
        }
    }
}
