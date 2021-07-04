//
//  ContentView.swift
//  Memorize
//
//  Created by Александр Биктеев on 03.07.2021.
//

import SwiftUI

struct ContentView: View {
    var emojisTravel = [["🚲", "🚂", "🚁", "🚜", "🚕", "🏎", "🚑", "🚓", "🚒",
                        "✈️", "🚀", "⛵️", "🛸", "🛶", "🚌", "🏍", "🛺", "🚠",
                        "🛵", "🚗", "🚚", "🚇", "🛻", "🚝"],
                        ["🏳️", "🏴", "🏴‍☠️", "🏁", "🚩", "🏳️‍🌈", "🏳️‍⚧️", "🇺🇳"],
                        ["🥞", "🍳", "🥙", "🥩", "🍗", "🍟", "🫔", "🌮"]]
    @State var emojisChose = 2
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            Text("Запомните!")
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                    ForEach(emojisTravel[emojisChose][0..<emojiCount].shuffled(), id: \.self,
                            content: {emoji in (CardView(content: emoji)).aspectRatio ( 2/3, contentMode: .fit)
                    })
                }.foregroundColor(.red)
            }
            HStack {
                VStack{
                    travel
                    Text("Vehicle").font(.body)
                }.padding(.horizontal, 16.0)
                VStack{
                    flags
                    Text("Flags").font(.body)
                }.padding(.horizontal, 16.0)
                VStack {
                    eat
                    Text("Eat").font(.body)
                }.padding(.horizontal, 16.0)
            }.foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Spacer()
            HStack {
                remove
                Spacer()
                add
            }
        }.font(.largeTitle)
    }
    
    var travel: some View {
        Button { if emojisChose != 0 {
            emojisChose = 0
        }
        } label: {
            Image(systemName: "car.circle")
        }
    }
    var flags: some View {
        Button { if emojisChose != 1 {
            emojisChose = 1
        }
        } label: {
            Image(systemName: "flag.circle")
        }
    }
    var eat: some View {
        Button { if emojisChose != 2 {
            emojisChose = 2
        }
        } label: {
            Image(systemName: "bag.circle")
        }
    }
    var remove: some View {
        Button { if emojiCount > 1 {
            emojiCount -= 1
        }
        } label: {
            Image(systemName: "minus.circle")
        }
    }
    var add: some View {
        Button { if emojiCount < emojisTravel.count {
            emojiCount += 1
        }
        } label: {
            Image(systemName: "plus.circle")
        }
    }
}

struct CardView: View {
    var content: String
    @State var isFaceUP = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUP {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text (content).font(.largeTitle)
            } else {
                shape.fill()
            }
            
        } .onTapGesture {
            isFaceUP = !isFaceUP
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
    }
}
