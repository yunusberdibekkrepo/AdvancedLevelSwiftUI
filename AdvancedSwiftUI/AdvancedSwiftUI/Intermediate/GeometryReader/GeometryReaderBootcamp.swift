//
//  GeometryReaderBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 19.01.2024.
//

import SwiftUI

/*
 Gereği olmadığı sürece kullanma.
 */

struct GeometryReaderBootcamp: View {
    func getPercentage(geo: GeometryProxy) -> Double {
        let maxDistance = UIScreen.main.bounds.width / 2
        let currentX = geo.frame(in: .global).midX
        return Double(1 - (currentX / maxDistance))
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(content: {
                ForEach(0 ..< 20) { _ in
                    GeometryReader(content: { geo in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                .degrees(getPercentage(geo: geo) * 40),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )

                    })
                    .frame(width: 300, height: 250)
                    .padding()
                }
            })
        }
//        GeometryReader(content: { geometry in
//            HStack(spacing: 0) {
//                Rectangle().fill(.red)
//                    .frame(width: geometry.size.width * 0.666)
//                Rectangle().fill(.blue)
//            }
//            .ignoresSafeArea()
//        })
    }
}

#Preview {
    GeometryReaderBootcamp()
}
