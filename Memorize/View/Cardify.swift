//
//  Cardify.swift
//  Memorize
//
//  Created by Александр Биктеев on 09.07.2021.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    init (isFaceUP: Bool) {
        rotation = isFaceUP ? 0 : 180
    }
    
    var animatableData: Double {
        get {rotation}
        set {rotation = newValue}
    }
    
    var rotation: Double //in Degress
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 10)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
            }  else {
                shape.fill()
            }
            content .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation),axis: (0, 1, 0)
        )
    }
}

extension View {
    func cardify(isFaceUP: Bool) -> some View {
        self.modifier(Cardify(isFaceUP: isFaceUP))
    }
}
