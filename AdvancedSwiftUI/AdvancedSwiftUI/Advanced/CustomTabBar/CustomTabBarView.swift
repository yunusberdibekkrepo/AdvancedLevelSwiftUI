//
//  CustomTabBarView.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import SwiftUI

struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    @State var localSelection: TabBarItem

    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { _, newValue in
                localSelection = newValue
            }
    }
}

#Preview {
    VStack {
        Spacer()
        CustomTabBarView(tabs: [.home, .favorite, .profile], selection: .constant(.home), localSelection: .home)
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(localSelection == tab ? tab.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.3) : .clear)
        .clipShape(.rect(cornerRadius: 10))
    }

    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab).onTapGesture {
                    switchToTab(tab: tab)
                }
            }
        }
        .padding(6)
        .background(.white).ignoresSafeArea()
    }

    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
}

extension CustomTabBarView {
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(localSelection == tab ? tab.color : .gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(tab.color.opacity(0.2))
                        .matchedGeometryEffect(id: "background_rect", in: namespace)
                }
            }
        )
    }

    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab).onTapGesture {
                    switchToTab(tab: tab)
                }
            }
        }
        .padding(6)
        .background(.white).ignoresSafeArea()
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
        .padding(.horizontal)
    }
}
