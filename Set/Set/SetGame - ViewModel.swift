//
//  SetGame - ViewModel.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

@Observable
class SetGameViewModel {
    static let figure = ["Circle", "Capsule", "RoundedRectangle"]
    static let color = ["Red", "Green", "Blue"]
    static let cardTexture = ["Fill", "Empty", "Shade"]
    static let number = ["One", "Two", "Three"]
    
    var model = SetModel()
    
    func newGame() {
        print(model.cards.count)
    }
    
    
    
    var card: [SetModel.Card] {
        model.cards
    }
    
    
    
}


