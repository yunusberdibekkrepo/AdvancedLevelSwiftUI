//
//  MatchedGeometryEffectBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 20.11.2023.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    @State private var isClicked: Bool = false
    @Namespace private var namespace

    var body: some View {
        VStack(content: {
            if !isClicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 100, height: 100)
            }

            Spacer()

            if isClicked {
                Circle()
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
        })
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.red)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

#Preview {
    VStack {
        MatchedGeometryEffectBootcamp()
        MatchedGeometryEffectExample2()
    }
}

struct MatchedGeometryEffectExample2: View {
    let categories: [String] = ["Home", "Popular", "Saved"]
    @State private var selected: String = ""
    @Namespace private var namespace2

    var body: some View {
        HStack(content: {
            ForEach(categories, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.red)
                            .matchedGeometryEffect(id: "categoryBackground", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 10)
                    }

                    Text(category)
                        .foregroundStyle(selected == category
                            ? .red : .black)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        })
        .padding()
    }
}
