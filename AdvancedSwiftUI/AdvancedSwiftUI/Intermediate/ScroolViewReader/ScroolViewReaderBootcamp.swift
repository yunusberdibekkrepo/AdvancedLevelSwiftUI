//
//  ScroolViewReaderBootcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 11.01.2024.
//

import SwiftUI

struct ScroolViewReaderBootcamp: View {
    /*
     Örnek olarak bir chat uygulamasında kullanılabilir. Mesela en son mesajları görmek için ekranın en üstünden en alta inmek gerekiyor.
     */
    @State var scroolToIndex: Int = 0
    @State var textFieldText: String = "30"

    var body: some View {
        VStack {
            TextField("Index...", text: $textFieldText)

            Button("CLİCK HERE TO GO TO NUMBER") {
                withAnimation(.spring) {
                    if let index = Int(textFieldText) {
                        scroolToIndex = index
                    }
                }
            }
            ScrollView {
                ScrollViewReader(content: { proxy in
                    ForEach(0 ..< 50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .clipShape(.rect(cornerRadius: 10))
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scroolToIndex) { _, newValue in
                        withAnimation(.spring) {
                            proxy.scrollTo(newValue, anchor: .center)
                        }
                    }
                })
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    ScroolViewReaderBootcamp()
}
