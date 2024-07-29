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
    
    private var numberOfCards = 12
    
    // Переменная, которая возвращает все карты
    var allCards: [Card] {
        model.cards
    }
    
    // Переменная, которая возвращает начальные карты
    var cards: [Card] {
        Array(model.cards[0..<numberOfCards])
        
    }
    
    // Переменная, которая возвращает true, когда карт нет в колоде
    var disableadButton: Bool {
        if model.cards.count == numberOfCards {
            return true
        } else {
            return false
        }
    }
    
    init() {
        model = SetGameViewModel.createSetGame()
    }
    
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
    
    func newGame() {
        model = SetGameViewModel.createSetGame()
        numberOfCards = 12
    }
    
    func chooseCard(_ card: Card) {
        model.choose(card)
    }
    
    // Функция выдачи трех карт 
    func giveCards() {
        if numberOfCards < allCards.count {
            numberOfCards += 3
            model.removeAtClick()
        }
    }
    
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
                if allCards[index].match == .correctly {
                    indexCard.append(allCards[index])
                }
                insert(indexCard)
            }
        }
        if numberOfCards > allCards.count {
            numberOfCards = allCards.count
        }
    }
    
    
    func cancelSelection() {
        model.cancelSelection()
    }
    
}


