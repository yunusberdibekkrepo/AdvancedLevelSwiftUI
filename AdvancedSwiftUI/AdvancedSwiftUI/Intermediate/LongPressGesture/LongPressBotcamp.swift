//
//  LongPressBotcamp.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 8.01.2024.
//

import SwiftUI

struct LongPressBotcamp: View {
    @State var isComplete = false
    @State var isSucces = false

    var body: some View {
        VStack(content: {
            Rectangle()
                .fill(isSucces ? .green : .blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)

            HStack(content: {
                Text("Click Here")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(.buttonBorder)
                    .onLongPressGesture(minimumDuration: 1, maximumDistance: 50) {
                        // At the min duration. Yani min duration bittikten sonra buraya girer.
                        print("perform")
                        withAnimation(.easeInOut) {
                            isSucces = true
                        }
                    } onPressingChanged: { isPressing in
                        // Start of press to min duration
                        if isPressing {
                            print("ispressing")
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete.toggle()
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                if !isSucces {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    }

                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(.buttonBorder)
                    .onTapGesture {
                        isComplete = false
                        isSucces = false
                    }
            })
        })
    }
}

#Preview {
    LongPressBotcamp()
}

/*
 .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { ... }: Bu kısım, bir uzun basma jesti algılandığında çalışacak olan kısmı temsil eder. minimumDuration parametresi, kullanıcının uzun basma hareketini belirli bir süre boyunca sürdürmesi gerektiğini belirtir. Burada 1.0 saniye olarak belirlenmiştir. maximumDistance parametresi ise kullanıcının parmağını hareket ettirmeden tutabileceği maksimum mesafeyi belirtir. Burada 50 piksel olarak belirlenmiştir.

 onPressingChanged: { isPressing in ... }: Bu kısım, uzun basma jestinin durumu değiştiğinde çalışacak olan kısmı temsil eder. Eğer isPressing değeri true ise, yani kullanıcı hala uzun basma jestini gerçekleştiriyorsa, bu durumda animasyonlu bir işlem gerçekleşir. withAnimation bloğu içinde, animasyonlu bir şekilde belirli bir süre boyunca isAnimating durumu değiştirilir. Bu durum, muhtemelen bir görsel öğenin animasyonlu bir şekilde değişmesini tetikler.

 Sonuç olarak, bu kod parçacığı, belirli bir süre boyunca belirli bir uzun basma jestini algıladığında ve jest devam ettiği süre boyunca bir animasyonu tetiklediğinde kullanılabilir.
 */
