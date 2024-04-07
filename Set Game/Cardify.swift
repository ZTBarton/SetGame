//
//  Cardify.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import SwiftUI

struct Cardify: Animatable, ViewModifier {
    var isSelected: Bool
    var isMatched: Bool
    var isMisMatched: Bool
    
    func body(content: Content) -> some View {
        GeometryReader { geometry in
            ZStack {
                if isMatched {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.green).opacity(0.2)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke(.green)
                } else if isMisMatched && isSelected {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.red).opacity(0.2)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke(.red)
                } else if isSelected {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.blue).opacity(0.2)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke(.blue)
                } else {
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).fill(.white)
                    RoundedRectangle(cornerRadius: cornerRadius(for: geometry.size)).stroke(.gray)
                }
                content.padding(geometry.size.width * Constants.paddingScaleFactor)
                
            }
        }
    }
    
    //    MARK: - Drawing Constants
        
    private func cornerRadius(for size: CGSize) -> Double {
        min(size.width, size.height) * 0.08
    }
            
    struct Constants {
        static let paddingScaleFactor = 0.1
    }
}

extension View {
    func cardify(isSelected: Bool, isMatched: Bool, isMisMatched: Bool) -> some View {
        modifier(Cardify(isSelected: isSelected, isMatched: isMatched, isMisMatched: isMisMatched))
    }
}
