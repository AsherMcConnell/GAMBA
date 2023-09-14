//
//  BlackJackTable.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/12/23.
//

import SwiftUI


struct CardSlot: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 15)
            .fill(Color.gray)
            .frame(width: 80, height: 120)
    }
}

struct CurvedBlackjackTable: View {
    var body: some View {
        VStack {
            Text("Blackjack")
                .font(.largeTitle)
                .padding(.top, 20)
            
            Spacer()
            
            HStack {
                CardSlot()
                Spacer()
                CardSlot()
            }
            
            HStack {
                Spacer()
                CardSlot()
                Spacer()
                CardSlot()
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                CardSlot()
                Spacer()
                CardSlot()
                Spacer()
            }
            
            HStack {
                Spacer()
                CardSlot()
                Spacer()
                CardSlot()
                Spacer()
            }
            
            Spacer()
            
            HStack {
                Spacer()
                CardSlot()
                Spacer()
                CardSlot()
                Spacer()
            }
            
            HStack {
                Spacer()
                CardSlot()
                Spacer()
                CardSlot()
                Spacer()
            }
            
        }
        .rotationEffect(.degrees(-10)) // Rotate the entire table
        .padding()
    }
}
