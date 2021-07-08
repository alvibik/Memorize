//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Александр Биктеев on 03.07.2021.
//

import SwiftUI

@main
struct MemorizeApp: App {
    let game = EmojiMemoryGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(game: game)
        }
    }
}
