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
    
    var selectedCardsIndexes: [Int] {
        get { cards.indices.filter { index in
            cards[index].selected
        }}
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            
            let isSelected = cards[chosenIndex].selected
            cards[chosenIndex].selected.toggle()
            
            if selectedCardsIndexes.count == 3 {
                let selectedCards = selectedCardsIndexes.map { cards[$0] }
                
                if let matchStatus = checkMatch(for: selectedCards) {
                    selectedIndexes.forEach { index in
                        cards[index].match = matchStatus
                    }
                }
            }
        }
    }
    
    
    mutating func checkMatch(for: ([Card]) -> Bool) {
        if selectedCardsIndexes.count == 3 {
            var threeCards: [Card] = []
            for i in selectedCardsIndexes {
                threeCards.append(cards[i])
            }
            if cardsMatch(threeCards) {
                for i in selectedCardsIndexes {
                    cards[i].match = .correctly
                    print(i)
                }
                
            } else {
                for i in selectedCardsIndexes {
                    cards[i].match = .wrong
                }
            }
        }
        
    }
    
    mutating func userSelected(card: Card, cardsMatch: ([Card]) -> Bool) {
        choose(card)
        if selectedCardsIndexes.count == 3 {
            checkMatch(cardsMatch: cardsMatch)
        }
        if selectedCardsIndexes.count == 4 {
            removeMatchedCards()
        }
    }
    
    mutating func removeMatchedCards() {
        for i in selectedCardsIndexes {
            cards.remove(at: i)
        }
        cancelSelection()
    }
    
    mutating func cancelSelection() {
        if selectedCardsIndexes.count <= 2 {
            for i in selectedCardsIndexes {
                cards[i].selected = false
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
