//
//  Set - Model.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import Foundation

struct SetModel<CardContent> {
    private(set) var cards: [Card] = []
    
    init(_ contentCards: [CardContent]) {
        self.cards.removeAll()
        
        for content in contentCards {
            self.cards.append(Card(contentCard: content, id: cards.count + 1))
        }
    }
    
    struct Card: Identifiable {
        var isMatch = false
        let contentCard: CardContent
        
        var id: Int
    }
}
