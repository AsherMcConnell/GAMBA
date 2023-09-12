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
    
    @Published var currentDrawnCards: [Card] = []
    
    func getNewDeck() async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else { return }
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
    func storeDrawnCards() async {
        if let drawnCards = drawCards {
            DispatchQueue.main.async {
                self.currentDrawnCards += drawnCards.cards
            }
        }
    }
}
