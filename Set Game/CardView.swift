//
//  CardView.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import SwiftUI

struct CardView: View {
    init(card: SetGame.Card, setSelected: Bool) {
        self.card = card
        
        switch card.shapeColor {
        case .red:
            shapeColor = .red
        case .green:
            shapeColor = .green
        case .purple:
            shapeColor = .purple
        }
        
        switch card.shapeCount {
            case .one:
                shapeCount = 1
            case .two:
                shapeCount = 2
            case .three:
                shapeCount = 3
        }
        
        switch card.shapeShade {
        case .solid:
            shapeShade = 1.0
        case .striped:
            shapeShade = 0.3
        case .open:
            shapeShade = 0.0
        }
//        print(setSelected)
        self.setSelected = setSelected
    }
    
    let card: SetGame.Card
    let shapeColor: Color
    let shapeCount: Int
    let shapeShade: Double
    let setSelected: Bool

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<shapeCount, id: \.self) { index in
                    switch card.shapeType {
                        case .oval:
                            ZStack {
                                Oval().foregroundColor(shapeColor).opacity(shapeShade)
                                Oval().stroke(lineWidth: 1).foregroundColor(shapeColor).opacity(1)
                            }.aspectRatio(1/2, contentMode: .fit)
                        case .diamond:
                            ZStack {
                                Diamond().foregroundColor(shapeColor).opacity(shapeShade)
                                Diamond().stroke(lineWidth: 1).foregroundColor(shapeColor).opacity(1)
                            }.aspectRatio(1/2, contentMode: .fit)
                        case .squiggle:
                            ZStack {
                                Squiggle().foregroundColor(shapeColor).opacity(shapeShade)
                                Squiggle().stroke(lineWidth: 1).foregroundColor(shapeColor).opacity(1)
                            }.aspectRatio(1/2, contentMode: .fit)
                    }
                }
            }
            .cardify(isSelected: card.isSelected, isMatched: card.isMatched, isMisMatched: !card.isMatched && setSelected)
            .transition(.scale)
            .foregroundStyle(.gray)
        }
        .aspectRatio(Card.aspectRatio, contentMode: .fit)
    }
    
    //    MARK: - Helper
    
    private func angle(for percentOfCircle: Double) -> Angle {
        Angle.degrees(percentOfCircle * 360 - 90)
    }
    
    //    MARK: - Drawing Constants
        
    struct Card {
        static let aspectRatio = 7.0 / 5.0
        static let cornerRadius = 10.0
        static let fontScaleFactor = 0.75
        static let paddingScaleFactor = 0.04
    }
    
    private func systemFont(for size: CGSize) -> Font {
        .system(size: min(size.width, size.height) * Card.fontScaleFactor)
    }
}
    
#Preview {
    CardView(card: SetGame.Card(shapeType: ShapeType.squiggle, shapeColor: ShapeColor.purple, shapeCount: ShapeCount.three, shapeShade: ShapeShade.striped), setSelected: false)
}
