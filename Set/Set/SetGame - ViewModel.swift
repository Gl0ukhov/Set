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
    
    // Переменная, которая содержит все карты
    var cards: [Card] {
        model.cards
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
        
        
        return SetModel(cardsContent.shuffled())
    }
    
    // Функция начала новой игры
    func newGame() {
        model = SetGameViewModel.createSetGame()
    }
    
    // Функция выбора карты
    func chooseCard(_ card: Card) {
        model.choose(card)
    }
    
    // Функция выдачи трех карт 
    func giveCards() {
        model.cardOpen()
        withAnimation(.easeOut(duration: 1)) {
            model.removeAtClick()
        }
    }
    
    // Функция проверки совпадения карт
    func checkMatch() {
        model.checkMatch { cards in
            var color: Set<Color> = []
            var number: Set<Int> = []
            var shading: Set<Double> = []
            var shape: Set<String> = []
            
            for index in cards {
                color.insert(model.cards[index].contentCard.color)
                number.insert(model.cards[index].contentCard.number)
                shading.insert(model.cards[index].contentCard.shading)
                shape.insert(model.cards[index].contentCard.shape.rawValue)
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
    func remove() {
        model.removeMatchedCards()
    }
    
    // Функция, которая перемешивает открытые карты
    func shuffle() {
        model.shuffleCard()
    }
    
}


