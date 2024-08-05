//
//  SetGame - ViewModel.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

@Observable
class SetGameViewModel {
    typealias Card = SetModel<CardContent>.Card
    typealias Model = SetModel<CardContent>
    
    private var model: Model
    
    // Переменная, которая содержит количество начальных карт
    private var numberOfCards = 12
    
    // Переменная, которая содержит все карты
    var cards: [Card] {
        model.cards
    }
    
    // Переменная, которая открытые карты
    var startCards: [Card] {
        Array(model.cards[0..<numberOfCards])
    }
    
    // Переменная, которая проверяет остаток в колоде
    var disableadButton: Bool {
        model.cards.count == numberOfCards ? true : false
    }
    
    // Инициализация модели
    init() {
        model = SetGameViewModel.createSetGame()
    }
    
    // Функция создания новой игры, добавление карт
    private static func createSetGame() -> Model {
        var cardsContent = [CardContent]()
        
        for shape in CardContent.Figure.allCases {
            for number in CardContent.allNumber {
                for shading in CardContent.allShading {
                    for color in CardContent.allColor {
                        let card = CardContent(shape: shape, number: number, shading: shading, color: color)
                        cardsContent.append(card)
                    }
                }
            }
        }
        return SetModel(cardsContent/*.shuffled()*/)
    }
    
    // Функция начала новой игры
    func newGame(insertCards: ([Card]) -> Void){
        model = SetGameViewModel.createSetGame()
        numberOfCards = 12
        startGame(insert: insertCards)
    }
    
    // Функция выбора карты
    func chooseCard(_ card: Card) {
        model.choose(card)
    }
    
    // Функция выдачи трех карт 
    func giveCards(insert: ([Card]) -> Void, remove: ([Card]) -> Void) {
        var card = [Card]()
        if numberOfCards < cards.count {
            numberOfCards += 3
            for i in (numberOfCards - 3)..<numberOfCards {
                card.append(cards[i])
            }
            insert(card)
            // MARK: Доделать - проблемы с анимацией
            model.removeAtClick { cardsIndex in
                var indexCard = [Card]()
                for index in cardsIndex {
                    if cards[index].match == .correctly {
                        indexCard.append(cards[index])
                    }
                    remove(indexCard)
                }
            }
        }
    }
    
    // Функция добавления начальных карт
    func startGame(insert: ([Card]) -> Void ) {
        insert(startCards)
    }
    
    // Функция проверки совпадения карт
    func checkMatch() {
        model.checkMatch { cards in
            var color: Set<Color> = []
            var number: Set<Int> = []
            var shading: Set<Double> = []
            var shape: Set<String> = []
            
            for item in cards {
                color.insert(item.contentCard.color)
                number.insert(item.contentCard.number)
                shading.insert(item.contentCard.shading)
                shape.insert(item.contentCard.shape.rawValue)
            }
            
            if color.count != 2 {
                if number.count != 2 {
                    if shading.count != 2 {
                        if shape.count != 2 {
                            return true
                        }
                    }
                }
            }
            return false
        }
    }
   
    // Функция, которая добавляет карты в сброс
    func remove(insert: ([Card]) -> Void) {
        model.removeMatchedCards { cardsIndex in
            var indexCard = [Card]()
            for index in cardsIndex {
                if cards[index].match == .correctly {
                    indexCard.append(cards[index])
                    
                }
            }
            insert(indexCard)
        }
        
    }
    
    func shuffle() {
        model.shuffleCard()
    }
    
}


