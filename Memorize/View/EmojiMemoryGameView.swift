//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Александр Биктеев on 03.07.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        //        ScrollView {
        //            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
        //                ForEach(game.cards) { card in
        AspectVGrid(items: game.cards, aspectRatio: 2/3, content: { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        })
        
        //                        }
        //                }
        //            }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 10)
                if card.isFaceUP {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text (card.content).font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.75))
                } else if card.isMatched {
                    shape.opacity(0)
                }  else {
                    shape.fill()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        EmojiMemoryGameView(game: game)
            .preferredColorScheme(.light)
    }
}
