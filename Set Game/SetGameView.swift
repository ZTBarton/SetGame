//
//  ContentView.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import SwiftUI

struct SetGameView: View {
    let currentGame: CurrentSetGame
    
    var body: some View {
        GeometryReader { geometry in
            if (currentGame.hasPressedStart) {
                VStack {
                    LazyVGrid(columns: columns(for: geometry.size)) {
                        ForEach(currentGame.dealtCards) { card in
                            CardView(card: card, setSelected: currentGame.threeSelected)
                                .transition(AnyTransition.offset(randomOffscreenLocation))
                                .onTapGesture {
                                    currentGame.choose(card)
                                }
                        }
                    }
                    Spacer()
                    HStack {
                        Button(action: {
                            currentGame.newGame()
                        }) {
                            Text("New Game")
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                        }
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                        Spacer()
                        Button(action: {
                            currentGame.dealThree()
                        }) {
                            Text("Deal 3 Cards")
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                        }
                        .background(currentGame.undealtCards.count == 0 ? Color.gray : Color.purple)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                        .disabled(currentGame.undealtCards.count == 0)
                    }
                }
                .padding()
            } else {
                HStack {
                    Spacer()
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                        Spacer()
                        Image("SetLogo")
                            .resizable()
                            .scaledToFit()
                            .padding(50)
                        Button(action: {
                            currentGame.newGame()
                        }) {
                            Text("Start Game")
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 3)
                        }
                        .background(Color.red)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                        Spacer()
                    }
                    Spacer()
                }.background(.purple)
            }
        }
        .onAppear {
            currentGame.dealCards()
        }
    }
    
    private var randomOffscreenLocation: CGSize {
        let radius = max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) * 1.5
        let factor: Double = Int.random(in: 0...1) > 0 ? 1 : -1
        
        return CGSize(width: factor * radius, height: factor * radius)
    }
    
//    MARK: - Drawing Constants
        
        private struct Game {
            static let desiredColumnCount = 3.0
            static let buttonStackHeight = 40.0
        }
        
        private func columns(for size: CGSize) -> [GridItem] {
            var columnCount = Game.desiredColumnCount
            
            let buttonHeight: CGFloat = 50.0
            let paddingHeight: CGFloat = 20.0
            let availableHeight = size.height - buttonHeight - paddingHeight

            let desiredCardWidth = size.width / Game.desiredColumnCount
            let desiredCardHeight = desiredCardWidth / CardView.Card.aspectRatio

            var currentCardHeight = desiredCardHeight
            var currentCardWidth = desiredCardWidth
            
            while ((ceil(Double(currentGame.dealtCards.count) / columnCount) * currentCardHeight) > availableHeight) {
                columnCount += 1
                currentCardWidth = size.width / columnCount
                currentCardHeight = currentCardWidth / CardView.Card.aspectRatio
            }
            
            return Array(repeating: GridItem(.flexible()), count: Int(columnCount))
        }
}

#Preview {
    SetGameView(currentGame: CurrentSetGame())
}
