//
//  ScroolViewOffsetPreferenceKeyBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import SwiftUI

struct ScroolViewOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScroolViewOffsetPreferenceKeyBootcamp: View {
    let title: String = "New Title Here"
    @State private var scroolViewOffset: CGFloat = .zero

    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(self.scroolViewOffset) / 63.0)
                    .onScroolViewOffsetChanged { offset in
                        self.scroolViewOffset = offset
                    }
                contentLayer
            }
            .padding()
        }
        .overlay(Text("\(self.scroolViewOffset)"))
        .overlay(
            navBarLayer.opacity(self.scroolViewOffset < 40 ? 1.0 : 0.0), alignment: .top
        )
    }
}

#Preview {
    ScroolViewOffsetPreferenceKeyBootcamp()
}

extension View {
    func onScroolViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader(content: { geo in
                    Text("")
                        .preference(key: ScroolViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                })
            )
            .onPreferenceChange(ScroolViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

extension ScroolViewOffsetPreferenceKeyBootcamp {
    private var titleLayer: some View {
        Text(self.title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var contentLayer: some View {
        ForEach(0 ..< 5) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }

    private var navBarLayer: some View {
        Text(self.title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
    }
}
