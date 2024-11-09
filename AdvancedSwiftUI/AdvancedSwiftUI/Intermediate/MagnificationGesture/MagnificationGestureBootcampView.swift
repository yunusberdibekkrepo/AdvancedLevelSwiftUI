//
//  MagnificationGestureBootcampView.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 10.01.2024.
//

import SwiftUI

struct MagnificationGestureBootcampView: View {
    @State var currentAmount: CGFloat = .zero
    @State var lastAmount: CGFloat = .zero

    var body: some View {
        VStack(spacing: 10, content: {
            HStack(content: {
                Circle()
                    .frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            })
            .padding(.horizontal)
            Rectangle()
                .frame(height: 350)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            currentAmount = value - 1
                        }
                        .onEnded { _ in
                            withAnimation(.spring) {
                                currentAmount = 0
                            }
                        }
                )
            HStack(content: {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            })
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        })
    }
}

#Preview {
    MagnificationGestureBootcampView()
}
