//
//  DiamondShape.swift
//  Set Game
//
//  Created by Zach Barton on 10/18/23.
//

import SwiftUI

struct Diamond: Shape {
    func path(in rect: CGRect) -> Path {
        let heightAdjustment  = rect.height * 0.0
        let startPoint = CGPoint(x: rect.maxX, y: rect.midY)
        let bottomPoint = CGPoint(x: rect.midX, y: rect.minY + heightAdjustment)
        let leftPoint = CGPoint(x: rect.minX, y: rect.midY)
        let topPoint = CGPoint(x: rect.midX, y: rect.maxY - heightAdjustment)
        var p = Path()

        p.move(to: startPoint)
        p.addLine(to: bottomPoint)
        p.addLine(to: leftPoint)
        p.addLine(to: topPoint)
        p.addLine(to: startPoint)
        p.addLine(to: bottomPoint)
        
        return p
    }
}

#Preview{
    Diamond()
        .foregroundStyle(.red)
        .opacity(0.4)
        .padding()
}
