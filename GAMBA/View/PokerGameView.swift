//
//  PokerGameView.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import SwiftUI

struct PokerGameView: View {
    
    @StateObject var pokerVM = PokerViewModel()
    
    var body: some View {
        ZStack {
            
            List {
                if let cards = pokerVM.cardsDrawn?.cards {
                    ForEach(cards, id: \.code) { card in
                        Image("\(card.value)\(card.suit)")
                            .resizable()
                            .scaledToFit()
                        Text(card.value)
                        Text(card.suit)
                        Text("\(pokerVM.deck?.remaining ?? 0)")
                    }
                }
            }
            Button {
                Task {
                    await pokerVM.drawCard(count: 2)
                    await pokerVM.getCurrentDeck()
                }
            } label: {
                Text("DRAW CARDS")
            }
        }
        .task {
            await pokerVM.getNewDeck()
        }
    }
}

struct PokerGameView_Previews: PreviewProvider {
    static var previews: some View {
        PokerGameView()
    }
}
