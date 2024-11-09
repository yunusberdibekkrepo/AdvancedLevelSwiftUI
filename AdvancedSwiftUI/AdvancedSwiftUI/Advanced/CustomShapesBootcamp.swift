//
//  CustomShapes.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 20.11.2023.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Square2: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        }
    }
}

struct Trapezoid: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            let horizontalOffset: CGFloat = rect.width * 0.2
            path.move(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - horizontalOffset, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + horizontalOffset, y: rect.minY))
        }
    }
}

struct CustomShapesBootcamp: View {
    var body: some View {
        VStack(content: {
            Square2()
                .frame(width: 300, height: 300)
//            Triangle()
//                .fill(.linearGradient(.init(colors: [.red, .blue]),
//                                      startPoint: .leading,
//                                      endPoint: .trailing))
//                .frame(width: 150, height: 150)
//
//            Triangle()
//                .stroke(.blue, style: .init(lineWidth: 2, lineCap: .round, dash: [10]), antialiased: true)
//                .frame(width: 150, height: 150)
//
//            Image(.messi)
//                .resizable()
//                .scaledToFill()
//                .frame(width: 300, height: 150)
//                .clipShape(Triangle()
//                    .rotation(.degrees(180)))
//
//            Diamond()
//                .frame(width: 200, height: 200)
//
//            Trapezoid()
//                .frame(width: 300, height: 100)
        })
    }
}

#Preview {
    CustomShapesBootcamp()
}
