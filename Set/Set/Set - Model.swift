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
    
    
    init() {
        cards = []
        
    }
    
    struct Card: Identifiable {
        var isMatch = false
        let figure: String
        let cardColor: String
        let numberOfSymbol: Int
        let cardTexture: String
        
        var id: String
    }
}
