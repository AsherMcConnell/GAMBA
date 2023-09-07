//
//  PokerViewModel.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import Foundation

class PokerViewModel: ObservableObject {
    
    @Published var deck: Deck? = nil
    @Published var cardsDrawn: CardsDrawn? = nil
    
    
    func getNewDeck() async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/new/shuffle/?deck_count=1") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedDeck = try JSONDecoder().decode(Deck.self, from: data)
            DispatchQueue.main.async {
                self.deck = decodedDeck
            }
            print("Successfully fetched Country from the internet")
            
        } catch let error {
            print("Error fetching Country from the internet. ERROR: \(error)")
        }
    }
    func getCurrentDeck() async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deck?.deckId ?? "FAIL")") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedDeck = try JSONDecoder().decode(Deck.self, from: data)
            DispatchQueue.main.async {
                self.deck = decodedDeck
            }
            print("Successfully fetched Country from the internet")
            
        } catch let error {
            print("Error fetching Country from the internet. ERROR: \(error)")
        }
    }
    func drawCard(count: Int) async {
        guard let url = URL(string: "https://deckofcardsapi.com/api/deck/\(deck?.deckId ?? "FAIL")/draw/?count=\(count)") else { return }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedCards = try JSONDecoder().decode(CardsDrawn.self, from: data)
            DispatchQueue.main.async {
                self.cardsDrawn = decodedCards
            }
            print("Successfully fetched CardsDrawn from the internet")
            
        } catch let error {
            print("Error fetching CardsDrawn from the internet. ERROR: \(error)")
        }
    }
}
