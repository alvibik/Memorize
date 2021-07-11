//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Биктеев on 04.07.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUPCard: Int? {
        get {cards.indices.filter({cards[$0].isFaceUP}).oneAndOnly}
        set {cards.indices.forEach {cards[$0].isFaceUP = ($0 == newValue) } }
    }
    
    mutating func choose (_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}),
           !cards[chosenIndex].isFaceUP,
           !cards[chosenIndex].isMatched
        {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUPCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUP = true
            } else {
                indexOfTheOneAndOnlyFaceUPCard = chosenIndex
            }
        
        }
        print ("\(cards)")
    }
    
    mutating func shuffle () {
        cards.shuffle()
    }
    
    init(numberOfpairsCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfpairsCards {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUP = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
