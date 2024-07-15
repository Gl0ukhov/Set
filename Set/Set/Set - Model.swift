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
    var selectedСards: [Int]? {
        get { cards.indices.filter { index in
            cards[index].selected
        }}
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            if let numberOfSelectedCards = selectedСards {
                if !cards[chosenIndex].selected && numberOfSelectedCards.count < 3 {
                    cards[chosenIndex].selected = true
                }
            }
        }
    }
    
    struct Card: Identifiable {
        var selected = false
        let contentCard: CardContent
        
        var id: Int
    }
}
