//
//  CurrentSetGame.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import SwiftUI

@Observable class CurrentSetGame {
    
//    MARK: - Properties
        
    var hasPressedStart = false
    private var game = createGame()
    fileprivate(set) var isVisible = false
    
    static func createGame() -> SetGame {
        SetGame()
    }
    
//    MARK: - Model access
    
    var undealtCards: Array<SetGame.Card> {
        game.undealtCards
    }
    
    var dealtCards: Array<SetGame.Card> {
        isVisible ? game.dealtCards : []
    }
    
    var selectedCards: Array<SetGame.Card> {
        game.dealtCards.filter { $0.isSelected }
    }
    
    var threeSelected: Bool {
        selectedCards.count > 2
    }
    
//    MARK: - User intents
    
    func dealCards() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            isVisible = true
        }
    }
    
    func dealThree() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            game.dealThree()
        }
    }
    
    func choose(_ card: SetGame.Card) {
        withAnimation(.easeIn(duration: Constants.animationDuration)) {
            game.choose(card: card)
        }
    }
    
    func newGame() {
        withAnimation(.easeInOut(duration: Constants.animationDuration)) {
            hasPressedStart = true
            isVisible = false
            game = CurrentSetGame.createGame()
        }
        dealCards()
    }
    
    private struct Constants {
        static let animationDuration = 0.5
    }
}
