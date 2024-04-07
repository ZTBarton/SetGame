//
//  Set_GameApp.swift
//  Set Game
//
//  Created by Zach Barton on 10/17/23.
//

import SwiftUI

@main
struct Set_GameApp: App {
    var body: some Scene {
        WindowGroup {
            SetGameView(currentGame: CurrentSetGame())
        }
    }
}
