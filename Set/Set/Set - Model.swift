//
//  Set - Model.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import Foundation
import SwiftUI

struct SetModel {
    private (set) var cards: [Card] = []
    
    
    init(figures: [String], colors: [String], numbers: [String], textures: [String]) {
        for figure in figures {
            for color in colors {
                for number in numbers {
                    for texture in textures {
                        let id = String(cards.count + 1)
                        cards.append(Card(figure: figure, cardColor: color, numberOfSymbol: number, cardTexture: texture, id: id))
                    }
                }
            }
        }
    }
    
    init(testCard: Int) {
        for i in 0..<testCard {
            cards.append(Card(figure: "figure", cardColor: "color", numberOfSymbol: "number", cardTexture: "texture", id: String(i)))
        }
    }
    
    struct Card: Identifiable {
        var isMatch = false
        let figure: String
        let cardColor: String
        let numberOfSymbol: String
        let cardTexture: String
        
        var id: String
    }
}
