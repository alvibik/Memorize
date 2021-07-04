//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Биктеев on 04.07.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: [Card]
    func choose (_ card: Card) {
        
    }
    struct Card {
        var isFaceUP: Bool
        var isMatched: Bool
        var content: CardContent
    }
}
