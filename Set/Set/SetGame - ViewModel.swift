//
//  SetGame - ViewModel.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

@Observable
class SetGameViewModel {
    private static let figure = ["Circle", "Capsule", "RoundedRectangle"]
    private static let color = ["Red", "Green", "Blue"]
    private static let number = ["One", "Two", "Three"]
    private static let cardTexture = ["Fill", "Empty", "Shade"]
    
    var model: SetModel
    
    var count = 0
    
    init() {
        model = SetGameViewModel.createSetGame()
    }
    
    private static func createSetGame() -> SetModel {
        SetModel(figures: figure, colors: color, numbers: number, textures: cardTexture)
//        SetModel(testCard: 3)
        
    }
    
    
    var card: [SetModel.Card] {
        model.cards
    }
    
    
    
}


