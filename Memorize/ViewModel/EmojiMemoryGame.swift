//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Александр Биктеев on 04.07.2021.
//

import SwiftUI

class EmojiMemoryGame{
    static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓",
                         "🚒","✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍",
                         "🛺", "🚠","🛵", "🚗", "🚚", "🚇", "🛻", "🚝"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfpairsCards: 4) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
}
