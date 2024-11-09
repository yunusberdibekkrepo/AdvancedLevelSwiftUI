//
//  PreferenceKeyBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.12.2023.
//

import SwiftUI

extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomPreferenceKey.self, value: text)
    }
}

struct PreferenceKeyBootcamp: View {
    @State private var text: String = "Hello, World!"

    var body: some View {
        NavigationStack {
            VStack {
                SecondaryScreen(text: self.text)
                    .navigationTitle("Title")
            }
        }.onPreferenceChange(CustomPreferenceKey.self) { value in
            self.text = value
        }
    }
}

#Preview {
    PreferenceKeyBootcamp()
}

struct SecondaryScreen: View {
    let text: String
    @State private var newValue: String = ""

    var body: some View {
        Text(self.text)
            .onAppear(perform: getDataFromDatabase)
            .customTitle(newValue)
    }

    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.newValue = "Updated value from database"
        }
    }
}

struct CustomPreferenceKey: PreferenceKey {
    static let defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

/*
 SwiftUI'da normalde en dıştaki katmandan en içteki katmana göre sıralanır. Yani en içteki katmanda bulunan bir view bir dıştaki katmanda bulunan bir view'daki veriyi değiştirmek için binding kullanabilir. Bunun dışında ise preference key kullanabilir. Böylece child olan view parent olan view'in özelliğini değiştirebilir. Örnek olarak navigationTitle özelliği olabilir. Bir sayfada içe doğru koysakta bulunduğu sayfanın title özelliğini değiştirir.
    Child view bir database'e gidip veri alıyorsa gelen bu veriyi parent view'a paslayabiliriz.
 */
