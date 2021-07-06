//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Биктеев on 04.07.2021.
//

import Foundation

struct MemoryGame<CardContent> {
    private(set) var cards: Array<Card>
    mutating func choose (_ card: Card) {
        let chosenIndex = index(of: card)
        cards[chosenIndex].isFaceUP.toggle()
        print ("\(cards)")
    }
    
    func index(of card: Card) -> Int {
        for index in 0..<cards.count {
            if cards[index].id == card.id{
                 return index
            }
        }
        return 0 
    }
    
    init(numberOfpairsCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfpairsCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUP = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
