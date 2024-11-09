//
//  ScroolViewPreferenceKey.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import SwiftUI

struct Names: Identifiable {
    let id: String
    let name: String
}

struct ScroolViewPreferenceKey: View {
    @State var isLoading: Bool = false
    @State var blackRectOffset: CGFloat = .zero
    @State var scroolHeight: CGFloat = .zero

    @State var names: [Names] = [
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
        .init(id: NSUUID().uuidString, name: NSUUID().uuidString),
    ]

    var body: some View {
        GeometryReader(content: { geometry in
            let height = geometry.size.height

            ScrollView {
                VStack {
                    ForEach(names, id: \.id) { name in
                        Text(name.name)
                            .padding(.top, 40)
                    }

                    if isLoading {
                        ProgressView()
                    } else {
                        GeometryReader(content: { geo in
                            Rectangle()
                                .fill(.black)
                                .frame(width: .infinity, height: 100)
                                .clipShape(.rect(cornerRadius: 12))
                                .preference(key: ScroolPreferenceKey.self,
                                            value: geo.frame(in: .global).minY)
                        })
                    }
                }
                .onPreferenceChange(ScroolPreferenceKey.self, perform: { value in
                    self.blackRectOffset = value
                })
                .onChange(of: blackRectOffset) { _, _ in
                    yazdir()
                }
            }
            .preference(key: GeometryScroolHeight.self, value: height)
            .overlay(
                VStack(spacing: 8, content: {
                    Text("blackRectOffset: \(blackRectOffset)")
                    Text("scroolheight: \(scroolHeight)")
                    Text("uiscreen height: \(UIScreen.main.bounds.height)")
                    Text("names count: \(names.count)")
                }).foregroundStyle(.red).bold(),
                alignment: .top)

        })
        .onPreferenceChange(GeometryScroolHeight.self, perform: { value in
            scroolHeight = value
        })
    }

    func yazdir() {
        isLoading = true
        let elementByOffset = blackRectOffset / CGFloat(names.count) // 2219 iken 110
        if blackRectOffset - scroolHeight < elementByOffset { // Padding, nav title, tab bar
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
            names.append(.init(id: NSUUID().uuidString, name: NSUUID().uuidString))
        }
        isLoading = false
    }
}

#Preview {
    ScroolViewPreferenceKey()
}

struct ScroolPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct GeometryScroolHeight: PreferenceKey {
    static var defaultValue: CGFloat = .zero

    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
