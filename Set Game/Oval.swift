//
//  OvalShape.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import SwiftUI

struct Oval: Shape {
    func path(in rect: CGRect) -> Path {
        let leftAngle = Angle(degrees: 360-180)
        let rightAngle = Angle(degrees: 0)
        let radius: Double = rect.height * 0.2
        let topCenter = CGPoint(x: rect.midX, y: rect.maxY - radius)
        let bottomCenter = CGPoint(x: rect.midX, y: rect.minY + radius)
        var p = Path()

        p.addArc(
            center: topCenter,
            radius: radius,
            startAngle: leftAngle,
            endAngle: rightAngle,
            clockwise: true
        )
        p.addArc(
            center: bottomCenter,
            radius: radius,
            startAngle: rightAngle,
            endAngle: leftAngle,
            clockwise: true
        )
        p.addLine(to: CGPoint(x: rect.midX - radius, y: rect.maxY - radius))
        
        return p
    }
}

#Preview{
    Oval()
        .foregroundStyle(.red)
        .opacity(0.4)
        .padding()
}
