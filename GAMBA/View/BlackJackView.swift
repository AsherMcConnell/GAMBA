//
//  PokerGameView.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import SwiftUI

struct BlackJackView: View {
    
    @StateObject var blackJackVM = BlackJackViewModel()
    
    @State var player1Color = Color.white
    @State var player2Color = Color.white
    @State var player3Color = Color.white
    @State var player4Color = Color.white
    @State var player5Color = Color.white
    
    @State var dealerColor = Color.white
    
    @State var newRoundOpacity = 1.0
    
    var body: some View {
        ZStack {
            Color.brown.ignoresSafeArea()
            table
            allplayers
            VStack {
                Spacer()
                HStack {
                    options
                        .padding(25)
                }
            }
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
            HalfCircleShape()
                .rotation(Angle(degrees: 180))
                .frame(width: 370, height: 200)
                .foregroundColor(Color(hue: 0.386, saturation: 0.695, brightness: 0.275))
                .offset(y: -100)
            PlayerSlotsView(curveHeight: 250, numShapes: 5, shapeSize: 70)
                .rotationEffect(.degrees(180))
                .frame(width: 650, height: 250)
            VStack {
                Image("CardBack")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 140)
                ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 30, height: 30)
                        .foregroundColor(dealerColor)
                    if blackJackVM.playerTurns[0] == 6 {
                        Text("\(blackJackVM.dealerScore.reduce(0, +))")
                    } else {
                        Text("?")
                    }
                }
                .position(x: 400, y: 0)
                //
                ZStack {
                        .frame(width: 250, height: 45)
                    if blackJackVM.playerTurns[0] == 6 {
                        Text("Dealer Flop")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                            .onAppear {
                                blackJackVM.houseDrawnCards[1].isFlipped = true
                                if blackJackVM.dealerScore.reduce(0, +) >= 17 && blackJackVM.dealerScore.reduce(0, +) <= 20 {
                                    newRoundOpacity = 1.0
                                    dealerColor = Color.yellow
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player1Score.reduce(0, +) {
                                        player1Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player1Score.reduce(0, +) {
                                        player1Color = .yellow
                                    } else if blackJackVM.player1Score.reduce(0, +) <= 21  {
                                        player1Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player2Score.reduce(0, +) {
                                        player2Color = .red
                                    }  else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player2Score.reduce(0, +) {
                                        player2Color = .yellow
                                    } else if blackJackVM.player2Score.reduce(0, +) <= 21  {
                                        player2Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player3Score.reduce(0, +) {
                                        player3Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player3Score.reduce(0, +) {
                                        player3Color = .yellow
                                    } else if blackJackVM.player3Score.reduce(0, +) <= 21  {
                                        player3Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player4Score.reduce(0, +) {
                                        player4Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player4Score.reduce(0, +) {
                                        player4Color = .yellow
                                    } else if blackJackVM.player4Score.reduce(0, +) <= 21  {
                                        player4Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player5Score.reduce(0, +) {
                                        player5Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player5Score.reduce(0, +) {
                                        player5Color = .yellow
                                    } else if blackJackVM.player5Score.reduce(0, +) <= 21  {
                                        player5Color = .green
                                    }
                                } else if blackJackVM.dealerScore.reduce(0, +) == 21 {
                                    dealerColor = .green
                                    newRoundOpacity = 1.0
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player1Score.reduce(0, +) {
                                        player1Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player1Score.reduce(0, +) {
                                        player1Color = .yellow
                                    } else if blackJackVM.player1Score.reduce(0, +) <= 21  {
                                        player1Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player2Score.reduce(0, +) {
                                        player2Color = .red
                                    }  else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player2Score.reduce(0, +) {
                                        player2Color = .yellow
                                    } else if blackJackVM.player2Score.reduce(0, +) <= 21  {
                                        player2Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player3Score.reduce(0, +) {
                                        player3Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player3Score.reduce(0, +) {
                                        player3Color = .yellow
                                    } else if blackJackVM.player3Score.reduce(0, +) <= 21  {
                                        player3Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player4Score.reduce(0, +) {
                                        player4Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player4Score.reduce(0, +) {
                                        player4Color = .yellow
                                    } else if blackJackVM.player4Score.reduce(0, +) <= 21  {
                                        player4Color = .green
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player5Score.reduce(0, +) {
                                        player5Color = .red
                                    } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player5Score.reduce(0, +) {
                                        player5Color = .yellow
                                    } else if blackJackVM.player5Score.reduce(0, +) <= 21  {
                                        player5Color = .green
                                    }
                                }
                            }
                            .onTapGesture {
                                Task {
                                    if blackJackVM.dealerScore.reduce(0, +) < 17 {
                                        await drawHit(player:.dealer)
                                    }
                                }
                                
                            }
                        
                    } else {
                        Text("Player \(blackJackVM.playerTurns[0])'s Turn")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .onChange(of: blackJackVM.playerTurns[0].description) { newValue in
                                
                                if blackJackVM.player1Score.reduce(0, +) == 21 && blackJackVM.playerTurns[0] == 1 {
                                    blackJackVM.playerTurns.remove(at: 0)
                                }
                                if blackJackVM.player2Score.reduce(0, +) == 21 && blackJackVM.playerTurns[0] == 2 {
                                    blackJackVM.playerTurns.remove(at: 0)
                                }
                                if blackJackVM.player3Score.reduce(0, +) == 21 && blackJackVM.playerTurns[0] == 3 {
                                    blackJackVM.playerTurns.remove(at: 0)
                                }
                                if blackJackVM.player4Score.reduce(0, +) == 21 && blackJackVM.playerTurns[0] == 4 {
                                    blackJackVM.playerTurns.remove(at: 0)
                                }
                                if blackJackVM.player5Score.reduce(0, +) == 21 && blackJackVM.playerTurns[0] == 5 {
                                    blackJackVM.playerTurns.remove(at: 0)
                                }
                            }
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 250, height: 45)
                        Button {
                            blackJackVM.reset()
                            player1Color = .white
                            player2Color = .white
                            player3Color = .white
                            player4Color = .white
                            player5Color = .white
                            dealerColor = .white
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                newRoundOpacity = 0
                                Task {
                                    await drawHit(player: .player1)
                                    await drawHit(player: .player2)
                                    await drawHit(player: .player3)
                                    await drawHit(player: .player4)
                                    await drawHit(player: .player5)
                                    await drawHit(player: .dealer)
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    Task {
                                        await drawHit(player: .player1)
                                        await drawHit(player: .player2)
                                        await drawHit(player: .player3)
                                        await drawHit(player: .player4)
                                        await drawHit(player: .player5)
                                        await drawHit(player: .dealer)
                                    }
                                }
                            }
                        } label: {
                            Text("NEW ROUND")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                                
                        }
                    }
                    .opacity(newRoundOpacity)
                }
                .position(x: 400, y: -70)
                Spacer()
            }
        }
    }
    var allplayers: some View {
        ZStack {
            player1CardView
            player2CardView
            player3CardView
            player4CardView
            player5CardView
            dealerCardView
        }
    }
    var options: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 100, height: 60)
                Button {
                    playerScoreSystem()
                } label: {
                    Text("HIT")
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
            }
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .frame(width: 110, height: 60)
                Button {
                    withAnimation(.easeIn(duration: 1)) {
                        if blackJackVM.playerTurns.count > 1 {
                            blackJackVM.playerTurns.remove(at: 0)
                        }
                    }
                } label: {
                    Text("STAND")
                        .font(.largeTitle)
                        .foregroundColor(.orange)
                }
            }
        }
    }
    
    var player1CardView: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(player1Color)
                Text("\(blackJackVM.player1Score.reduce(0, +))")
                
            }
            .position(x: 620, y: 370)
            ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 30)
                        .foregroundColor(player1Color)
                    Text("Player 1")
            }
            .position(x: 620, y: 505)
            
            withAnimation(.linear(duration: 1.0)) {
                HStack(spacing: -40) {
                    ForEach(0..<blackJackVM.player1Cards.count, id: \.self) { index in
                        CardView(isFaceUp:blackJackVM.player1Cards[index].isFlipped ?? false, card: blackJackVM.player1Cards[index])
                            .frame(width: 70, height: 140)
                            .offset(x: blackJackVM.player1Cards[index].positionX ?? 100 ,y: blackJackVM.player1Cards[index].positionY ?? -100)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    blackJackVM.player1Cards[index].isFlipped = true
                                    blackJackVM.player1Cards[index].positionX = 220
                                    blackJackVM.player1Cards[index].positionY = 240
                                }
                                
                                blackJackVM.player1Score.append(blackJackVM.player1Cards[index].value.toInt() ?? 0)
                                if blackJackVM.player1Score.reduce(0, +) == 21 {
                                    player1Color = Color.green
                                }
                                
                                if blackJackVM.playerTurns[0] == 1 {
                                    if blackJackVM.player1Score.reduce(0, +) > 21 {
                                        for (index, value) in blackJackVM.player1Score.enumerated() {
                                            if value == 11 {
                                                blackJackVM.player1Score.remove(at: index)
                                                blackJackVM.player1Score.insert(1, at: index)
                                                return
                                            }
                                        }
                                        player1Color = Color.red
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                    if blackJackVM.player1Score.reduce(0, +) == 21 {
                                        player1Color = Color.green
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                }
                            }
                    }
                }
            }
        }
        .rotationEffect(Angle(degrees: -70))
    }
    var player2CardView: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(player2Color)
                Text("\(blackJackVM.player2Score.reduce(0, +))")
            }
            .position(x: 530, y: 307)
            ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 30)
                        .foregroundColor(player2Color)
                    Text("Player 2")
            }
            .position(x: 530, y: 442)
            withAnimation(.linear(duration: 1.0)) {
                HStack(spacing: -40) {
                    ForEach(0..<blackJackVM.player2Cards.count, id: \.self) { index in
                        CardView(isFaceUp:blackJackVM.player2Cards[index].isFlipped ?? false, card: blackJackVM.player2Cards[index])
                            .frame(width: 70, height: 140)
                            .offset(x: blackJackVM.player2Cards[index].positionX ?? 100 ,y: blackJackVM.player2Cards[index].positionY ?? -100)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    blackJackVM.player2Cards[index].isFlipped = true
                                    blackJackVM.player2Cards[index].positionX = 129
                                    blackJackVM.player2Cards[index].positionY = 175
                                }
                                blackJackVM.player2Score.append(blackJackVM.player2Cards[index].value.toInt() ?? 0)
                                if blackJackVM.player2Score.reduce(0, +) == 21 {
                                    player2Color = Color.green
                                }
                                if blackJackVM.playerTurns[0] == 2 {
                                    if blackJackVM.player2Score.reduce(0, +) > 21 {
                                        for (index, value) in blackJackVM.player2Score.enumerated() {
                                            if value == 11 {
                                                blackJackVM.player2Score.remove(at: index)
                                                blackJackVM.player2Score.insert(1, at: index)
                                                return
                                            }
                                        }
                                        player2Color = Color.red
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                    if blackJackVM.player2Score.reduce(0, +) == 21 {
                                        player2Color = Color.green
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                }
                            }
                    }
                }
            }
        }
        .rotationEffect(Angle(degrees:-40))
    }
    var player3CardView: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(player3Color)
                Text("\(blackJackVM.player3Score.reduce(0, +))")
            }
            .position(x: 400, y: 256)
            ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 30)
                        .foregroundColor(player3Color)
                    Text("Player 3")
            }
            .position(x: 400, y: 391)
            withAnimation(.linear(duration: 1.0)) {
                HStack(spacing: -40) {
                    ForEach(0..<blackJackVM.player3Cards.count, id: \.self) { index in
                        CardView(isFaceUp:blackJackVM.player3Cards[index].isFlipped ?? false, card: blackJackVM.player3Cards[index])
                            .frame(width: 70, height: 140)
                            .offset(x: blackJackVM.player3Cards[index].positionX ?? 0 ,y: blackJackVM.player3Cards[index].positionY ?? -100)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    blackJackVM.player3Cards[index].isFlipped = true
                                    blackJackVM.player3Cards[index].positionX = 0
                                    blackJackVM.player3Cards[index].positionY = 125
                                    
                                }
                                blackJackVM.player3Score.append(blackJackVM.player3Cards[index].value.toInt() ?? 0)
                                if blackJackVM.player3Score.reduce(0, +) == 21 {
                                    player3Color = Color.green
                                }
                                
                                if blackJackVM.playerTurns[0] == 3 {
                                    if blackJackVM.player3Score.reduce(0, +) > 21 {
                                        for (index, value) in blackJackVM.player3Score.enumerated() {
                                            if value == 11 {
                                                blackJackVM.player3Score.remove(at: index)
                                                blackJackVM.player3Score.insert(1, at: index)
                                                return
                                            }
                                        }
                                        player3Color = Color.red
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                    if blackJackVM.player3Score.reduce(0, +) == 21 {
                                        player3Color = Color.green
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                }
                            }
                    }
                }
            }
        }
    }
    var player4CardView: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(player4Color)
                Text("\(blackJackVM.player4Score.reduce(0, +))")
            }
            .position(x: 270, y: 308)
            ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 30)
                        .foregroundColor(player4Color)
                    Text("Player 4")
            }
            .position(x: 270, y: 443)
            withAnimation(.linear(duration: 1.0)) {
                HStack(spacing: -40) {
                    ForEach(0..<blackJackVM.player4Cards.count, id: \.self) { index in
                        CardView(isFaceUp:blackJackVM.player4Cards[index].isFlipped ?? false, card: blackJackVM.player4Cards[index])
                            .frame(width: 70, height: 140)
                            .offset(x: blackJackVM.player4Cards[index].positionX ?? -100 ,y: blackJackVM.player4Cards[index].positionY ?? -100)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    blackJackVM.player4Cards[index].isFlipped = true
                                    blackJackVM.player4Cards[index].positionX = -129
                                    blackJackVM.player4Cards[index].positionY = 175
                                    
                                }
                                blackJackVM.player4Score.append(blackJackVM.player4Cards[index].value.toInt() ?? 0)
                                if blackJackVM.player4Score.reduce(0, +) == 21 {
                                    player4Color = Color.green
                                }
                                if blackJackVM.playerTurns[0] == 4 {
                                    if blackJackVM.player4Score.reduce(0, +) > 21 {
                                        for (index, value) in blackJackVM.player4Score.enumerated() {
                                            if value == 11 {
                                                blackJackVM.player4Score.remove(at: index)
                                                blackJackVM.player4Score.insert(1, at: index)
                                                return
                                            }
                                        }
                                        player4Color = Color.red
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                    if blackJackVM.player4Score.reduce(0, +) == 21 {
                                        player4Color = Color.green
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                }
                            }
                    }
                }
            }
        }
        .rotationEffect(Angle(degrees: 40))
    }
    var player5CardView: some View {
        ZStack {
            ZStack {
                RoundedRectangle(cornerRadius: 5)
                    .frame(width: 30, height: 30)
                    .foregroundColor(player5Color)
                Text("\(blackJackVM.player5Score.reduce(0, +))")
            }
            .position(x: 180, y: 370)
            ZStack {
                    RoundedRectangle(cornerRadius: 5)
                        .frame(width: 100, height: 30)
                        .foregroundColor(player5Color)
                    Text("Player 1")
            }
            .position(x: 180, y: 505)
            withAnimation(.linear(duration: 1.0)) {
                HStack(spacing: -40) {
                    ForEach(0..<blackJackVM.player5Cards.count, id: \.self) { index in
                        CardView(isFaceUp:blackJackVM.player5Cards[index].isFlipped ?? false, card: blackJackVM.player5Cards[index])
                            .frame(width: 70, height: 140)
                            .offset(x: blackJackVM.player5Cards[index].positionX ?? -100 ,y: blackJackVM.player5Cards[index].positionY ?? -100)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    blackJackVM.player5Cards[index].isFlipped = true
                                    blackJackVM.player5Cards[index].positionX = -220
                                    blackJackVM.player5Cards[index].positionY = 240
                                    
                                }
                                blackJackVM.player5Score.append(blackJackVM.player5Cards[index].value.toInt() ?? 0)
                                if blackJackVM.player5Score.reduce(0, +) == 21 {
                                    player5Color = Color.green
                                }
                                if blackJackVM.playerTurns[0] == 5 {
                                    
                                    if blackJackVM.player5Score.reduce(0, +) > 21 {
                                        for (index, value) in blackJackVM.player5Score.enumerated() {
                                            if value == 11 {
                                                blackJackVM.player5Score.remove(at: index)
                                                blackJackVM.player5Score.insert(1, at: index)
                                                return
                                            }
                                        }
                                        player5Color = Color.red
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                    if blackJackVM.player5Score.reduce(0, +) == 21 {
                                        player5Color = Color.green
                                        blackJackVM.playerTurns.remove(at: 0)
                                    }
                                }
                            }
                        
                    }
                }
            }
        }
        .rotationEffect(Angle(degrees: 70))
    }
    var dealerCardView: some View {
        ZStack {
            withAnimation(.linear(duration: 1.0)) {
                HStack(spacing: -40) {
                    ForEach(0..<blackJackVM.houseDrawnCards.count, id: \.self) { index in
                        CardView(isFaceUp:blackJackVM.houseDrawnCards[index].isFlipped ?? false, card: blackJackVM.houseDrawnCards[index])
                            .frame(width: 70, height: 140)
                            .offset(x: blackJackVM.houseDrawnCards[index].positionX ?? 0 ,y: blackJackVM.houseDrawnCards[index].positionY ?? -130)
                            .onAppear {
                                withAnimation(.easeIn(duration: 1.0)) {
                                    if index != 1 {
                                        blackJackVM.houseDrawnCards[index].isFlipped = true
                                    }
                                    blackJackVM.houseDrawnCards[index].positionX = -20
                                    blackJackVM.houseDrawnCards[index].positionY = -125
                                    
                                }
                                blackJackVM.dealerScore.append(blackJackVM.houseDrawnCards[index].value.toInt() ?? 0)
                                
                                if blackJackVM.playerTurns[0] == 6 {
                                    if blackJackVM.dealerScore.reduce(0, +) >= 17 && blackJackVM.dealerScore.reduce(0, +) <= 20 {
                                        dealerColor = Color.yellow
                                        newRoundOpacity = 1.0
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player1Score.reduce(0, +) {
                                            player1Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player1Score.reduce(0, +) {
                                            player1Color = .yellow
                                        } else if blackJackVM.player1Score.reduce(0, +) <= 21  {
                                            player1Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player2Score.reduce(0, +) {
                                            player2Color = .red
                                        }  else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player2Score.reduce(0, +) {
                                            player2Color = .yellow
                                        } else if blackJackVM.player2Score.reduce(0, +) <= 21  {
                                            player2Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player3Score.reduce(0, +) {
                                            player3Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player3Score.reduce(0, +) {
                                            player3Color = .yellow
                                        } else if blackJackVM.player3Score.reduce(0, +) <= 21  {
                                            player3Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player4Score.reduce(0, +) {
                                            player4Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player4Score.reduce(0, +) {
                                            player4Color = .yellow
                                        } else if blackJackVM.player4Score.reduce(0, +) <= 21  {
                                            player4Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player5Score.reduce(0, +) {
                                            player5Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player5Score.reduce(0, +) {
                                            player5Color = .yellow
                                        } else if blackJackVM.player5Score.reduce(0, +) <= 21  {
                                            player5Color = .green
                                        }
                                    } else if blackJackVM.dealerScore.reduce(0, +) == 21 {
                                        newRoundOpacity = 1.0
                                        dealerColor = .green
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player1Score.reduce(0, +) {
                                            player1Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player1Score.reduce(0, +) {
                                            player1Color = .yellow
                                        } else if blackJackVM.player1Score.reduce(0, +) <= 21  {
                                            player1Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player2Score.reduce(0, +) {
                                            player2Color = .red
                                        }  else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player2Score.reduce(0, +) {
                                            player2Color = .yellow
                                        } else if blackJackVM.player2Score.reduce(0, +) <= 21  {
                                            player2Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player3Score.reduce(0, +) {
                                            player3Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player3Score.reduce(0, +) {
                                            player3Color = .yellow
                                        } else if blackJackVM.player3Score.reduce(0, +) <= 21  {
                                            player3Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player4Score.reduce(0, +) {
                                            player4Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player4Score.reduce(0, +) {
                                            player4Color = .yellow
                                        } else if blackJackVM.player4Score.reduce(0, +) <= 21  {
                                            player4Color = .green
                                        }
                                        if blackJackVM.dealerScore.reduce(0, +) > blackJackVM.player5Score.reduce(0, +) {
                                            player5Color = .red
                                        } else if blackJackVM.dealerScore.reduce(0, +) == blackJackVM.player5Score.reduce(0, +) {
                                            player5Color = .yellow
                                        } else if blackJackVM.player5Score.reduce(0, +) <= 21  {
                                            player5Color = .green
                                        }
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) > 21 {
                                        for (index, value) in blackJackVM.dealerScore.enumerated() {
                                            if value == 11 {
                                                blackJackVM.dealerScore.remove(at: index)
                                                blackJackVM.dealerScore.insert(1, at: index)
                                                return
                                            }
                                        }
                                        dealerColor = Color.red
                                        newRoundOpacity = 1.0
                                        
                                        if blackJackVM.player1Score.reduce(0, +) <= 21 {
                                            player1Color = .green
                                        }
                                        if blackJackVM.player2Score.reduce(0, +) <= 21 {
                                            player2Color = .green
                                        }
                                        if blackJackVM.player3Score.reduce(0, +) <= 21 {
                                            player3Color = .green
                                        }
                                        if blackJackVM.player4Score.reduce(0, +) <= 21 {
                                            player4Color = .green
                                        }
                                        if blackJackVM.player5Score.reduce(0, +) <= 21 {
                                            player5Color = .green
                                        }
                                    }
                                    if blackJackVM.dealerScore.reduce(0, +) == 21 {
                                        dealerColor = Color.green
                                        newRoundOpacity = 1.0
                                    }
                                    
                                }
                            }
                    }
                }
            }
        }
    }
}

// MARK: FUNCS

extension BlackJackView {
    func drawHit(player: Player) async {
        await blackJackVM.drawCard(count: 1)
        await blackJackVM.getCurrentDeck()
        await blackJackVM.storeDrawnCards(player: player)
    }
    
    func playerScoreSystem(){
        Task {
            if blackJackVM.playerTurns[0] == 1 {
                if blackJackVM.player1Score.reduce(0, +) >= 21 {
                } else {
                    await drawHit(player:.player1)
                }
            }
            if blackJackVM.playerTurns[0] == 2 {
                if blackJackVM.player2Score.reduce(0, +) >= 21 {
                } else {
                    await drawHit(player:.player2)
                }
            }
            if blackJackVM.playerTurns[0] == 3 {
                if blackJackVM.player3Score.reduce(0, +) >= 21 {
                } else {
                    await drawHit(player:.player3)
                }
            }
            if blackJackVM.playerTurns[0] == 4 {
                if blackJackVM.player4Score.reduce(0, +) >= 21 {
                } else {
                    await drawHit(player:.player4)
                }
            }
            if blackJackVM.playerTurns[0] == 5 {
                if blackJackVM.player5Score.reduce(0, +) >= 21 {
                } else {
                    await drawHit(player:.player5)
                }
            }
        }
    }
    
}


//func playerCardDisplay(player: Player) -> some View {
//    var playerCards: [Card]
//    var positionX: CGFloat
//    var positionY: CGFloat
//
//    switch player {
//    case .player1 : playerCards = blackJackVM.player1Cards; positionX = 400; positionY = -130
//    case .player2 : playerCards = blackJackVM.player2Cards; positionX = 200; positionY = 50
//    case .player3 : playerCards = blackJackVM.player3Cards; positionX = 0; positionY = 125
//    case .player4 : playerCards = blackJackVM.player4Cards; positionX = -200; positionY = 50
//    case .player5 : playerCards = blackJackVM.player5Cards; positionX = 400; positionY = -130
//    }
//    return ZStack {
//        HStack(spacing: -40) {
//            ForEach(0..<playerCards.count, id: \.self) { index in
//                CardView(isFaceUp: playerCards[index].isFlipped ?? false, card: playerCards[index])
//                    .frame(width: 70, height: 140)
//                    .offset(x: playerCards[index].positionX ?? 0 ,y: playerCards[index].positionY ?? -130)
//                    .onAppear {
//                        withAnimation(.easeIn(duration: 1.0)) {
//                            playerCards[index].isFlipped = true
//                            playerCards[index].positionX = positionX
//                            playerCards[index].positionY = positionY
//
//                        }
//                    }
//            }
//        }
//    }
//}

