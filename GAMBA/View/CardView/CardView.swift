//
//  CardView.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import SwiftUI

struct CardView: View {
    var isFaceUp: Bool
    var card: Card
    
    var body: some View {
        ZStack {
            Image("\(card.value)\(card.suit)")
                .resizable()
                .scaledToFit()
        }
        .cardify(isFaceUp: isFaceUp)
    }
}

struct Cardify: AnimatableModifier {
    
    var rotation: Double
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    private struct DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
    func body(content: Content) -> some View {
        ZStack {
            if rotation > 90 {
                Image("CardBack")
                    .resizable()
                    .scaledToFit()
            }
            content
                .opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        return self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}

