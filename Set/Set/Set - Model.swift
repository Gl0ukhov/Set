//
//  Set - Model.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import Foundation
import SwiftUI

struct SetModel {
    private (set) var cards: [Card]
    
    
    init(figure: [String], cardColor: [String], numberOfSymbol: [String], cardTexture: [String]) {
        cards = []
        for fig in 0..<3 {
            cards.append(Card(figure: figure[fig], cardColor: nil, numberOfSymbol: nil, cardTexture: nil, id: "1"))
            for color in cards {
                cards.append(Card(figure: color.figure, cardColor: cardColor[fig], numberOfSymbol: nil, cardTexture: nil, id: "1"))
            }
            for number in cards {
                cards.append(Card(figure: number.figure, cardColor: number.cardColor, numberOfSymbol: numberOfSymbol[fig], cardTexture: nil, id: "1"))
            }
            for texture in cards {
                cards.append(Card(figure: texture.figure, cardColor: texture.cardColor, numberOfSymbol: texture.numberOfSymbol, cardTexture: cardTexture[fig], id: "1"))
            }
        }
    }
    
    struct Card: Identifiable {
        var isMatch = false
        let figure: String?
        let cardColor: String?
        let numberOfSymbol: String?
        let cardTexture: String?
        
        var id: String
    }
}
