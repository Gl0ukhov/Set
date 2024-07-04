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
                        cards.append(Card(shapeType: figure, color: color, numberOfSymbol: number, fill: texture, id: id))
                    }
                }
            }
        }
    }
    
    init(testCard: Int) {
        for _ in 0..<testCard {
            cards.append(Card(shapeType: "Circle", color: "Red", numberOfSymbol: "One", fill: "Fill", id: UUID().uuidString))
            cards.append(Card(shapeType: "Capsule", color: "Green", numberOfSymbol: "Two", fill: "Empty", id: UUID().uuidString))
            cards.append(Card(shapeType: "RoundedRectangle", color: "Blue", numberOfSymbol: "Three", fill: "Shade", id: UUID().uuidString))
        }
    }
    
    struct Card: Identifiable {
        var isMatch = false
        let shapeType: String
        let color: String
        let numberOfSymbol: String
        let fill: String
        
        var id: String
    }
}
