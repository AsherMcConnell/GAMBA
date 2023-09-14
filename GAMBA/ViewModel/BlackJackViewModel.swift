//
//  PokerViewModel.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import Foundation

class BlackJackViewModel: ObservableObject {
    @Published var currentDeck: Deck? = nil
    @Published var drawCards: CardsDrawn?
    
    @Published var houseDrawnCards: [Card] = []
    @Published var player1Cards: [Card] = []
    @Published var player2Cards: [Card] = []
    @Published var player3Cards: [Card] = []
    @Published var player4Cards: [Card] = []
    @Published var player5Cards: [Card] = []
    
    @Published var player1Score = [0]
    @Published var player2Score = [0]
    @Published var player3Score = [0]
    @Published var player4Score = [0]
    @Published var player5Score = [0]
    @Published var dealerScore = [0]
    
    @Published var playerTurns = [1,2,3,4,5,6]
    
    func getNewDeck() async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=6") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedDeck = try JSONDecoder().decode(Deck.self, from: data)
            DispatchQueue.main.async {
                self.currentDeck = decodedDeck
            }
            print("Successfully fetched newDeck from the internet")
            
        } catch let error {
            print("Error fetching newDeck from the internet. ERROR: \(error)")
        }
    }
    func getCurrentDeck() async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(currentDeck?.deckId ?? "FAIL")") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedDeck = try JSONDecoder().decode(Deck.self, from: data)
            DispatchQueue.main.async {
                self.currentDeck = decodedDeck
            }
            print("Successfully fetched currentDeck from the internet")
            
        } catch let error {
            print("Error fetching currentDeck from the internet. ERROR: \(error)")
        }
    }
    func drawCard(count: Int) async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(currentDeck?.deckId ?? "FAIL")/draw/?count=\(count)") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedCards = try JSONDecoder().decode(CardsDrawn.self, from: data)
            DispatchQueue.main.async {
                self.drawCards = decodedCards
            }
            print("Successfully fetched CardsDrawn from the internet")
            
        } catch let error {
            print("Error fetching CardsDrawn from the internet. ERROR: \(error)")
        }
    }
    
    func storeDrawnCards(player: Player) async {
        if let drawnCards = drawCards {
            DispatchQueue.main.async {
                switch player {
                case .player1: self.player1Cards += drawnCards.cards
                case .player2: self.player2Cards += drawnCards.cards
                case .player3: self.player3Cards += drawnCards.cards
                case .player4: self.player4Cards += drawnCards.cards
                case .player5: self.player5Cards += drawnCards.cards
                case .dealer: self.houseDrawnCards += drawnCards.cards
                }
            }
        }
    }
    func reset() {
        
        houseDrawnCards.removeAll()
        player1Cards.removeAll()
        player2Cards.removeAll()
        player3Cards.removeAll()
        player4Cards.removeAll()
        player5Cards.removeAll()
        
        player1Score = [0]
        player2Score = [0]
        player3Score = [0]
        player4Score = [0]
        player5Score = [0]
        dealerScore = [0]
        
        playerTurns = [1,2,3,4,5,6]
    }
}

extension String {
    func toInt() -> Int? {
        if self == "QUEEN" || self == "KING" || self == "JACK" {
            return 10
        } else if self == "ACE" {
            return 11
        }
        return Int(self)
    }
    func toOne() -> Int? {
        if self == "ACE" {
            return 1
        }
        return Int(self)
    }
}


