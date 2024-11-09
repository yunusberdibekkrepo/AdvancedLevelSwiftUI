//
//  CustomCurves.swift
//  AdvancedSwiftUI
//
//  Created by Yunus Emre Berdibek on 20.11.2023.
//

import SwiftUI

struct CustomCurvesBootcamp: View {
    var body: some View {
        VStack(alignment: .center, spacing: 100) {
            ArcSample()
                .frame(width: 200, height: 200)

            ShapeWithArc()
                .frame(width: 200, height: 200)

            QuadSample()
                .frame(width: 200, height: 200)

            WaterShape()
                .fill(.blue.gradient)
                .frame(width: 200, height: 200)
        }
        .padding()
    }
}

#Preview {
    CustomCurvesBootcamp()
}

struct ArcSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.midX, y: rect.midY))
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY),
                radius: rect.height / 2,
                startAngle: .degrees(-20),
                endAngle: .degrees(20),
                clockwise: true)
        }
    }
}

struct ShapeWithArc: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            // top left
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))

            // top right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))

            // mid right
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))

            // bottom
            path.addArc(
                center: CGPoint(x: rect.midX, y: rect.midY - 65),
                radius: rect.height / 2,
                startAngle: .degrees(0),
                endAngle: .degrees(180),
                clockwise: false)
            // path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))

            // mid left
            path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        }
    }
}

struct QuadSample: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)

            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.maxX - 50, y: rect.minY))
        }
    }
}

struct WaterShape: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.midY))

            path.addQuadCurve(
                to: CGPoint(x: rect.midX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.25,
                                 y: rect.height * 0.40))

            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.midY),
                control: CGPoint(x: rect.width * 0.75,
                                 y: rect.height * 0.60))

            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        }
    }
}
