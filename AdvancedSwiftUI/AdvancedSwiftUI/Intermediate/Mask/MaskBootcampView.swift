//
//  MaskBootcampView.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 21.01.2024.
//

import SwiftUI

struct MaskBootcampView: View {
    @State var rating: Int = 0

    var body: some View {
        ZStack(content: {
            starsView
                .overlay(
                    overlayView
                        .mask(starsView)
                )
        })
    }

    private var overlayView: some View {
        GeometryReader(content: { geometry in
            ZStack(alignment: .leading, content: {
                Rectangle()
                    .foregroundStyle(
                        .linearGradient(
                            colors: [.red, .blue],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: CGFloat(rating) / 5 * geometry.size.width)
            })
        })
        .allowsHitTesting(false) // Tıklanabilirliği kalktı.
    }

    private var starsView: some View {
        HStack(content: {
            ForEach(1 ..< 6) { index in
                Image(systemName: "star.fill")
                    .font(.largeTitle)
                    .foregroundStyle(.gray)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            rating = index
                        }
                    }
            }
        })
    }
}

#Preview {
    MaskBootcampView()
}
