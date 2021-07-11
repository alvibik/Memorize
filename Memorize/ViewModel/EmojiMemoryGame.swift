//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Александр Биктеев on 04.07.2021.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    static let emojis = ["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓",
                         "🚒","✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍",
                         "🛺", "🚠","🛵", "🚗", "🚚", "🚇", "🛻", "🚝"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfpairsCards: 10) { pairIndex in
            EmojiMemoryGame.emojis[pairIndex]
        }
    }
    
    @Published private var model: MemoryGame<String> = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    //MARK: - Intent(s)
    func choose (_ card: MemoryGame<String>.Card) {
        objectWillChange.send()
        model.choose(card)
    }
    func shuffle () {
        model.shuffle()
    }
    func restart () {
        model = EmojiMemoryGame.createMemoryGame()
    }
}
