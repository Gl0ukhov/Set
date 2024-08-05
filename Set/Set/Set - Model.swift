//
//  Set - Model.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import Foundation

struct SetModel<CardContent> where CardContent: Hashable {
    // Массив карточек
    private(set) var cards: [Card] = []
    
    // Создание карточек
    init(_ contentCards: [CardContent]) {
        for content in contentCards {
            self.cards.append(Card(contentCard: content))
        }
    }
    
    // Фильтр по картам, у которых свойство selected = true
    private var selectedCardsIndexes: [Int] {
        get { cards.indices.filter { index in
            cards[index].selected
        }}
    }
    
    
    
    // Фильтр по картам, у которых свойство match != nChecked
    private var matchedCardsIndexes: [Int] {
        get { cards.indices.filter { index in
            cards[index].match != .nChecked
        }}
    }
    
    // Функция выбора карты и изменения selected свойства
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            cards[chosenIndex].selected.toggle()
        }
    }
    
    // Функция проверки карты на соответствие правилам
    mutating func checkMatch(cardsMatch: ([Card]) -> Bool) {
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
    
    // Функция удаления совпавших карт
    mutating func removeMatchedCards(_ indexCard: ([Int]) -> Void) {
        if selectedCardsIndexes.count == 4 {
            let indexToDiscard = matchedCardsIndexes.sorted(by: >)
            indexCard(indexToDiscard)
            clearSelection()
            clearMatch()
        }
    }
    
    mutating func removeAtClick(_ indexCard: ([Int]) -> Void) {
        if selectedCardsIndexes.count == 3 {
            let indexToDiscard = matchedCardsIndexes.sorted(by: >)
            indexCard(indexToDiscard)
            clearSelection()
            clearMatch()
        }
    }
    
    private mutating func clearSelection() {
        for index in cards.indices {
            cards[index].selected = false
        }
    }
    
    private mutating func clearMatch() {
        for index in cards.indices {
            cards[index].match = .nChecked
        }
    }
    
    
    mutating func shuffleCard() {
        cards.shuffle()
    }
    
    struct Card: Identifiable, Hashable {
        var selected = false
        var match = CardStatus.nChecked
        let contentCard: CardContent
        
        var id = UUID()
        
        enum CardStatus {
            case correctly, wrong, nChecked
        }
        
    }
}
