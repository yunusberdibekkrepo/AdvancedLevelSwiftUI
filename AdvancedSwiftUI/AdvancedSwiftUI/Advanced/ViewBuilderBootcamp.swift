//
//  ViewBuilderBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 10.12.2023.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description {
                Text(description)
                    .font(.callout)
            }
            if let iconName {
                Image(systemName: iconName)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct HeaderViewGeneric<T: View>: View {
    let title: String
    let content: T

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct HeaderViewGenericBuilder<Content: View>: View {
    let title: String
    let content: Content

    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            content
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct CustomHStack<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HStack {
            content
        }
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        VStack {
            HeaderViewRegular(title: "Title",
                              description: "Description",
                              iconName: "heart.fill")
                .padding()
            HeaderViewRegular(title: "Title", description: nil, iconName: nil)
                .padding()

            HeaderViewGeneric(title: "Generic Title 1", content: Text("Hi!"))
                .padding()

            HeaderViewGeneric(title: "Generic Title 2", content: Image(systemName: "heart.fill"))
                .padding()

            HeaderViewGeneric(title: "Generic Title 2", content:
                HStack(content: {
                    Text("Placeholder")
                    Image(systemName: "bolt.fill")
                        .font(.title)
                        .foregroundStyle(.blue)
                    Text("Placeholder")
                }))
                .padding()

            HeaderViewGenericBuilder(title: "Generic Title Builder 1") {
                HStack {
                    Text("Hallo")
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.blue)
                    Text("Hallo")
                }
            }
            .padding()

            CustomHStack {
                Text("Custom HStack")
                Text("Custom HStack")
            }
            .padding()

            Spacer()
        }
    }
}

#Preview {
    ViewBuilderBootcamp()
}
