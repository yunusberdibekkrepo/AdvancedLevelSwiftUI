//
//  GeometryPreferenceKeyBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import SwiftUI

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

struct GeometryPreferenceKeyBootcamp: View {
    @State private var rectSize: CGSize = .zero

    var body: some View {
        VStack {
            Spacer()
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height)
                .background(.blue)
            Spacer()
            HStack {
                Rectangle()
                GeometryReader(content: { geometry in
                    Rectangle()
                        .updateRectangleGeoSize(geometry.size)
                })
                Rectangle()
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { newValue in
            self.rectSize = newValue
        })
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero

    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
