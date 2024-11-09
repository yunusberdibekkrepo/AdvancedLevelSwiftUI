//
//  GenericsBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 6.12.2023.
//

import SwiftUI

struct StringModel {
    let info: String?

    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

struct GenericModel<T> {
    let info: T?

    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

class GenericsViewModel: ObservableObject {
    @Published var stringModel: StringModel = .init(info: "Hello, Yunus")

    @Published var genericStringModel = GenericModel(info: "Hello, World")
    @Published var genericBoolModel = GenericModel(info: false)

    func removeData() {
        stringModel = stringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    let content: T
    let title: String

    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    @StateObject private var viewModel: GenericsViewModel = .init()

    var body: some View {
        VStack {
            GenericView(content: Image(systemName: "tv").font(.title), title: "Generic view")
            Text(viewModel.stringModel.info ?? "No string data")
            Text(viewModel.genericStringModel.info ?? "No generic string data")
            Text(viewModel.genericBoolModel.info?.description ?? "No generic bool data")
        } //: VStack
        .onTapGesture {
            viewModel.removeData()
        }
    }
}

#Preview {
    GenericsBootcamp()
}
