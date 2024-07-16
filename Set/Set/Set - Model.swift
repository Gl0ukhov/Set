//
//  Set - Model.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import Foundation

struct SetModel<CardContent> where CardContent: Hashable {
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
            if let selectedCardsIndexes = selectedСards {
                if !cards[chosenIndex].selected && selectedCardsIndexes.count < 3 {
                    cards[chosenIndex].selected = true
                }
            }
        }
    }
    
    mutating func match(_ cardsMatch: ([Card]) -> Bool) {
        if let selectedCardsIndexes = selectedСards {
            if selectedCardsIndexes.count == 3 {
                var threeCards: [Card] = []
                for i in selectedCardsIndexes {
                    threeCards.append(cards[i])
                }
                if cardsMatch(threeCards) {
                    for i in selectedCardsIndexes {
                        cards[i].match = .correctly
                    }
                } else {
                    for i in selectedCardsIndexes {
                        cards[i].match = .wrong
                    }
                }
            }
        }
    }
    
    mutating func cancelSelection() {
        if let numberOfSelectedCards = selectedСards {
            if numberOfSelectedCards.count <= 2 {
                for i in numberOfSelectedCards {
                    cards[i].selected = false
                }
            }
        }
    }
    
    struct Card: Identifiable, Hashable {
        var selected = false
        var match = CardStatus.nChecked
        let contentCard: CardContent
        
        
        var id: Int
        
        enum CardStatus {
            case correctly, wrong, nChecked
        }
    }
}
