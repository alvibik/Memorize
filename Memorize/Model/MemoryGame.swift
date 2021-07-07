//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Биктеев on 04.07.2021.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUPCard: Int?
    
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
                indexOfTheOneAndOnlyFaceUPCard = nil
            } else {
                for index in cards.indices {
                    cards[index].isFaceUP = false
                }
                indexOfTheOneAndOnlyFaceUPCard = chosenIndex
            }
        cards[chosenIndex].isFaceUP.toggle()
        }
        print ("\(cards)")
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
