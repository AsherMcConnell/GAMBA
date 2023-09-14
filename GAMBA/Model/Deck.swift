//
//  Deck.swift
//  GAMBA
//
//  Created by Asher McConnell on 9/7/23.
//

import Foundation

struct Deck: Codable {
    let success: Bool
    let deckId: String
    let remaining: Int
    let shuffled: Bool
    
    enum CodingKeys: String, CodingKey {
        case success
        case deckId = "deck_id"
        case remaining
        case shuffled
    }
}

struct CardsDrawn: Codable {
    let cards: [Card]
}

struct Card: Codable {
    let code: String
    let image: String
    let images: Image
    let value: String
    let suit: String
    
    var isFlipped: Bool?
    var positionX: CGFloat?
    var positionY: CGFloat?
        
    struct Image: Codable {
        let svg: String
        let png: String
    }
}
enum Player {
    case player1
    case player2
    case player3
    case player4
    case player5
    case dealer
}
