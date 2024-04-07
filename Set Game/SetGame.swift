//
//  SetGame.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import Foundation

struct SetGame {
    var undealtCards: Array<Card>
    var dealtCards: Array<Card>
    
    init() {
//        create a card of each type by looping through all the enums
        undealtCards = []
        dealtCards = []
        for shape in ShapeType.allCases {
            for color in ShapeColor.allCases {
                for count in ShapeCount.allCases {
                    for shade in ShapeShade.allCases {
                        undealtCards.append(Card(shapeType: shape, shapeColor: color, shapeCount: count, shapeShade: shade))
                    }
                }
            }
        }
        undealtCards.shuffle()
//        deal 12 cards
        for index in 0..<12 {
            dealtCards.append(undealtCards[index])
            undealtCards.remove(at: index)
        }
    }
    
    func isSet(cards: Array<Card>) -> Bool {
//        Add up the count of each case. If there are any with 2 we know it isn't a set.
        var caseCount: Array<Int> = []
        
        for shape in ShapeType.allCases {
            var count = 0
            for card in cards {
                if card.shapeType == shape {
                    count += 1
                }
            }
            caseCount.append(count)
        }
        
        for color in ShapeColor.allCases {
            var count = 0
            for card in cards {
                if card.shapeColor == color {
                    count += 1
                }
            }
            caseCount.append(count)
        }
        
        for shapeCount in ShapeCount.allCases {
            var count = 0
            for card in cards {
                if card.shapeCount == shapeCount {
                    count += 1
                }
            }
            caseCount.append(count)
        }
        
        for shade in ShapeShade.allCases {
            var count = 0
            for card in cards {
                if card.shapeShade == shade {
                    count += 1
                }
            }
            caseCount.append(count)
        }
        
        return !caseCount.contains(2)
    }

    

    mutating func choose(card: Card) {
        if let chosenIndex = dealtCards.firstIndex(matching: card) {
            let alreadySelected = dealtCards.filter { $0.isSelected }
//            if three cards are already selected, unselect them unless they are a match.
            if alreadySelected.count == 3 {
                var hadMatch = false
                for selectedCard in alreadySelected {
                    if let indextoDeselect = dealtCards.firstIndex(matching: selectedCard) {
                        if dealtCards[indextoDeselect].isMatched {
                            dealtCards.remove(at: indextoDeselect)
                            hadMatch = true
                        } else {
                            dealtCards[indextoDeselect].isSelected.toggle()
                        }
                    }

                }
                if hadMatch {
                    dealThree()
                }
            }
//            select the new card
            dealtCards[chosenIndex].isSelected.toggle()
            
            let newSelected = dealtCards.filter { $0.isSelected }
            
//            if that was the third card, check if it's a match
            if newSelected.count == 3 {
                if isSet(cards: newSelected) {
                    for matchedCard in newSelected {
                        if let indextoMatch = dealtCards.firstIndex(matching: matchedCard) {
                            dealtCards[indextoMatch].isMatched.toggle()
                        }
                    }
                }
            }
        }
    }
    
    mutating func dealThree() {
        if undealtCards.count >= 3 {
            let cardsToDeal = undealtCards[0...2]
            for cardToDeal in cardsToDeal {
                dealtCards.append(cardToDeal)
                if let indextoremove = undealtCards.firstIndex(matching: cardToDeal) {
                    undealtCards.remove(at: indextoremove)
                }
            }
        }
    }
    
    struct Card: Identifiable {
        init(shapeType: ShapeType, shapeColor: ShapeColor, shapeCount: ShapeCount, shapeShade: ShapeShade) {
            self.shapeType = shapeType
            self.shapeColor = shapeColor
            self.shapeCount = shapeCount
            self.shapeShade = shapeShade
        }
        
        fileprivate(set) var id = UUID()
        fileprivate(set) var isSelected = false
        fileprivate(set) var isMatched = false

        fileprivate(set) var shapeType: ShapeType
        fileprivate(set) var shapeColor: ShapeColor
        fileprivate(set) var shapeCount: ShapeCount
        fileprivate(set) var shapeShade: ShapeShade
    }
}

// MARK: - Constants

enum ShapeType: CaseIterable {
    case oval
    case diamond
    case squiggle
}

enum ShapeColor: CaseIterable {
    case red
    case green
    case purple
}

enum ShapeCount: CaseIterable {
    case one
    case two
    case three
}

enum ShapeShade: CaseIterable {
    case solid
    case striped
    case open
}
