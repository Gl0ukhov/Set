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
        return SetModel(cardsContent)
    }
    
    
    var cards: [Card] {
        Array(model.cards[0..<12])
    }
    
    
    
    func newGame() {
        model = SetGameViewModel.createSetGame()
    }
    
    func giveCards() {
        
    }
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func test() {
        model.match { card in
            var color: Set<Color> = []
            var number: Set<Int> = []
            var shading: Set<Double> = []
            var shape: Set<String> = []
            
            for item in card {
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
    
    
    func cancelSelection() {
        model.cancelSelection()
    }
    
    
    
}


