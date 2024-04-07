//
//  Array+Identifiable.swift
//  Set Game
//
//  Created by Zach Barton on 10/18/23.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex(matching targetElement: Element) -> Int? {
        for index in self.indices {
            if self[index].id == targetElement.id {
                return index
            }
        }
        return nil
    }
}
