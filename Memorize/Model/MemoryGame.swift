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
    
    init(numberOfpairsCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfpairsCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    struct Card {
        var isFaceUP = false
        var isMatched = false
        var content: CardContent
    }
}
