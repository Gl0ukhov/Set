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
        for index in 0..<12 {
            cards[index].status = .open
        }
    }
    
    // Фильтр по картам, которые не открыты
    private var cardsDeck: [Int] {
        get { cards.indices.filter { index in
            cards[index].status == .deck
        }}
    }
    
    private var cardsOpen: [Int] {
        get { cards.indices.filter { index in
            cards[index].status == .open
        } }
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
    
    // Функция открытия карт
    mutating func cardOpen() {
        guard cardsDeck.count > 0 else {
            return
        }
    
        for i in cardsDeck[0..<3] {
            cards[i].status = .open
        }
    }
    
    // Функция выбора карты и изменения selected свойства
    mutating func choose(_ card: Card) {
        guard card.match == .nChecked else {
            return
        }
        
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id}) {
            cards[chosenIndex].selected.toggle()
        }
    }
    
    // Функция проверки карты на соответствие правилам
    mutating func checkMatch(cardsMatch: ([Int]) -> Bool) {
        guard selectedCardsIndexes.count <= 3 else {
            return
        }
        
        if selectedCardsIndexes.count == 3 {
            if cardsMatch(selectedCardsIndexes) {
                selectedCardsIndexes.forEach { cards[$0].match = .correctly }
            } else {
                selectedCardsIndexes.forEach { cards[$0].match = .wrong }
            }
        }
    }
    
    // Функция удаления совпавших карт после нажатия на 4 карту
    mutating func removeMatchedCards() {
        if selectedCardsIndexes.count == 4 {
            for index in matchedCardsIndexes {
                if cards[index].match == .correctly {
                    cards[index].status = .discard
                }
            }
            clearSelectionAndMatch()
        }
    }
    
    // Функция удаления совпавших карт после нажатия на колоду
    mutating func removeAtClick() {
        if selectedCardsIndexes.count == 3 {
            for index in matchedCardsIndexes {
                if cards[index].match == .correctly {
                    cards[index].status = .discard
                }
            }
            clearSelectionAndMatch()
        }
    }
    
    // Функция убирает select и match
    private mutating func clearSelectionAndMatch() {
        for index in cards.indices {
            cards[index].selected = false
            cards[index].match = .nChecked
        }
    }
    
    // Функция перемешивания карт
    mutating func shuffleCard() {
        var array: [Card] = []
        for i in cardsOpen {
            array.append(cards[i])
        }
        array.shuffle()
        for i in cardsOpen {
            cards[i] = array.first!
            array.removeFirst()
        }
    }
    
    struct Card: Identifiable, Hashable {
        var selected = false
        var status = CardStatus.deck
        var match = CardMatch.nChecked
        let contentCard: CardContent
        
        var id = UUID()
        
        enum CardMatch {
            case correctly, wrong, nChecked
        }
        
        enum CardStatus {
            case deck, open, discard
        }
    }
}
