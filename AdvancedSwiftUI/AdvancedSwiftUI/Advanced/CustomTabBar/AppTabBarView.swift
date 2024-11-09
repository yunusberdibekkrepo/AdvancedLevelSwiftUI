//
//  AppTabBarView.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import SwiftUI

// Generics
// ViewBuilder
// PreferenceKey
// MatchGeometryEffect

struct AppTabBarView: View {
    @State private var selection: String = "home"
    @State private var tabSelection: TabBarItem = .home

    var body: some View {
        CustomTabBarContainerView(selection: $tabSelection) {
            Color.blue
                .tabBarItem(tab: .home, selection: $tabSelection)

            Color.red
                .tabBarItem(tab: .favorite, selection: $tabSelection)

            Color.green
                .tabBarItem(tab: .profile, selection: $tabSelection)
        }
    }
}

#Preview {
    AppTabBarView()
}

extension AppTabBarView {
    private var defaultTabView: some View {
        TabView(selection: $selection,
                content: {
                    Color.red.tabItem {
                        Image(systemName: "house")
                        Text("Home")
                    }
                    Color.blue.tabItem {
                        Image(systemName: "heart")
                        Text("Favorites")
                    }
                    Color.green.tabItem {
                        Image(systemName: "person")
                        Text("Profile")
                    }
                })
    }
}
