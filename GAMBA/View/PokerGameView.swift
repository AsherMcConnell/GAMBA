//
//  PokerGameView.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import SwiftUI

struct PokerGameView: View {
    
    @StateObject var pokerVM = PokerViewModel()
    
    @State var flipCard = false
    var body: some View {
        ZStack {
            table
            HStack {
                ForEach(0..<pokerVM.currentDrawnCards.count, id: \.self) { index in
                    CardView(isFaceUp: pokerVM.currentDrawnCards[index].isFlipped ?? false, card: pokerVM.currentDrawnCards[index])
                        .frame(width: 70, height: 120)
                        .onTapGesture {
                            withAnimation {
                                pokerVM.currentDrawnCards[index].isFlipped = true
                            }
                        }
                }
            }
            VStack {
                Spacer()
                HStack {
                    Button {
                        Task {
                            await drawFlop()
                        }
                    } label: {
                        Text("DRAW FLOP")
                    }
                    Button {
                        Task {
                            await drawTurn()
                        }
                    } label: {
                        Text("DRAW TURN")
                    }
                    
                }
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
            .previewInterfaceOrientation(.landscapeRight)
        
    }
}

// MARK: VIEWS

extension PokerGameView {
    var table: some View {
        ZStack {
            Ellipse()
                .frame(width: 600, height: 300)
            VStack {
                HStack {
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(.red)
                    Spacer()
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(.red)
                }
                Spacer()
                HStack {
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(.red)
                    Spacer()
                    Circle()
                        .frame(width: 80)
                        .foregroundColor(.red)
                }
            }
        }
        .padding(.top, 10)
        
    }
    
}

// MARK: FUNCS

extension PokerGameView {
    func drawFlop() async {
        await pokerVM.drawCard(count: 3)
        await pokerVM.getCurrentDeck()
        await pokerVM.storeDrawnCards()
    }
    func drawTurn() async {
        await pokerVM.drawCard(count: 1)
        await pokerVM.getCurrentDeck()
        await pokerVM.storeDrawnCards()
    }
    
}
