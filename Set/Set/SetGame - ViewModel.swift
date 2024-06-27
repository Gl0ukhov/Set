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
        return SetModel(figure: SetGameViewModel.figure, cardColor: SetGameViewModel.color, numberOfSymbol: SetGameViewModel.number, cardTexture: SetGameViewModel.cardTexture)
    }
    
    func numberOfcard() {
        count = 0
        for i in 0..<3 {
            count += i
            for k in 0..<3 {
                count += k
                for j in 0..<3 {
                    count += j
                    for l in 0..<3 {
                        count += l
                        
                    }
                }
            }
        }
        print(count)
    }
    
    var card: [SetModel.Card] {
        model.cards
    }
    
    
    
}


