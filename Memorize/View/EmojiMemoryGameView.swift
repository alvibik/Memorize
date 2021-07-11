//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Александр Биктеев on 03.07.2021.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack (alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                } .padding(.horizontal)
            }
                deckBody
            }
        .padding()
    }
    
    @State private var dealIt = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealIt.insert(card.id)
    }
    
    private func isUnDealIt(_ card: EmojiMemoryGame.Card) -> Bool{
        !dealIt.contains (card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
        var delay = 0.0
        if let index = game.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CordConstants.totalDealDuration / Double(game.cards.count))
        }
        return Animation.easeInOut(duration: CordConstants.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double {
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUnDealIt(card) || card.isMatched && !card.isFaceUP {
                Color.clear
            } else {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation{
                            game.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(.red)
        //  .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.cards.filter(isUnDealIt)) {card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CordConstants.undealtWidht, height: CordConstants.undealtHeight)
        .foregroundColor(CordConstants.color)
        .onTapGesture {
            withAnimation {
                withAnimation(.easeInOut(duration: 5)) {
                    for card in game.cards {
                        withAnimation(dealAnimation(for: card)) {
                            deal(card)
                        }
                    }
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                game.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            dealIt = []
            game.restart()
        }
    }
    
    private struct CordConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidht = undealtHeight * aspectRatio
    }
}

struct CardView: View {
    let card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90))
                    .padding(5).opacity(0.5)
                Text (card.content)
                    .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.7))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1) .repeatForever(autoreverses: false))
                    .scaleEffect(scale(thatFits: geometry.size))
            }
            .cardify(isFaceUP: card.isFaceUP)
        }
    }
    private func scale (thatFits size: CGSize) -> CGFloat {
        min(size.width, size.height) / (32 / 0.5)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        //game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
