//
//  ToolbarBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 7.01.2024.
//

import SwiftUI

struct ToolbarBootcamp: View {
    @State var showingScreen: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                if !showingScreen {
                    Text("Screen 1")
                } else {
                    Text("Screen 2")
                }
            }
            .navigationTitle("Toolbar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarTitleMenu {
                Button("Screen 1") {
                    showingScreen = false
                }

                Button("Screen 2") {
                    showingScreen = true
                }
            }
        }
    }
}

#Preview {
    ToolbarBootcamp()
}
