//
//  PokerGameView.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import SwiftUI

struct BlackJackView: View {
    
    @StateObject var blackJackVM = BlackJackViewModel()
    
    @State var flipCard = false
    
    @State var cardPositionX: CGFloat = 0
    @State var cardPositionY: CGFloat = 125
    
    var body: some View {
        ZStack {
            table
            startGame
            cardio
           
        }
        .task {
            await blackJackVM.getNewDeck()
        }
    }
}

struct BlackJackView_Previews: PreviewProvider {
    static var previews: some View {
        BlackJackView()
            .previewInterfaceOrientation(.landscapeRight)
        
    }
}

// MARK: VIEWS

extension BlackJackView {
    var table: some View {
        ZStack {
            HalfCircleShape()
                .rotation(Angle(degrees: 180))
                .frame(width: 800, height: 400)
                .foregroundColor(Color(hue: 0.386, saturation: 0.709, brightness: 0.505))
            PlayerSlotsView(curveHeight: 250, numShapes: 5, shapeSize: 50)
                .rotationEffect(.degrees(180))
                .frame(width: 650, height: 250)
        }
    }
    var cardio: some View {
        ZStack {
            ForEach(0..<blackJackVM.currentDrawnCards.count, id: \.self) { index in
                CardView(isFaceUp: blackJackVM.currentDrawnCards[index].isFlipped ?? false, card: blackJackVM.currentDrawnCards[index])
                    .frame(width: 50, height: 120)
                    .offset(x: cardPositionX ,y: cardPositionY)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 0.7)) {
                            blackJackVM.currentDrawnCards[index].isFlipped = true
                        }
                    }
                
            }
        }
    }
    var startGame: some View {
        Button {
            Task {
               await drawTurn()
            }
        } label: {
            Text("START")
        }
    }
}

// MARK: FUNCS

extension BlackJackView {
    func drawHit() async {
        await blackJackVM.drawCard(count: 1)
        await blackJackVM.getCurrentDeck()
        await blackJackVM.storeDrawnCards()
    }
    func drawTurn() async {
        await blackJackVM.drawCard(count: 1)
        await blackJackVM.getCurrentDeck()
        await blackJackVM.storeDrawnCards()
    }
    
}
