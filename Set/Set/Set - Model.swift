//
//  Set - Model.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import Foundation

struct SetModel<CardContent> {
    private(set) var cards: [Card] = []
    
    init(_ cards: [CardContent]) {
        self.cards.removeAll()
        
        for card in cards {
            self.cards.append(Card(card: card, id: cards.count + 1))
        }
    }
    
    struct Card: Identifiable {
        var isMatch = false
        let card: CardContent
        
        var id: Int
    }
}
