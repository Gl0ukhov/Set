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
        
        for shape in CardContent.Shape.allCases {
            for number in CardContent.Number.allCases {
                for shading in CardContent.Shading.allCases {
                    for color in CardContent.Color.allCases {
                        let card = CardContent(shape: shape, number: number, shading: shading, color: color)
                        cardsContent.append(card)
                    }
                }
            }
        }
        return SetModel(cardsContent)
    }
    
    
    var cards: [Card] {
        model.cards
    }
    
    func newGame() {
        model = SetGameViewModel.createSetGame()
    }
    
    func giveCards() {

    }
    
}


