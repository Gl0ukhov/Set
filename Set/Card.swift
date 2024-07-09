//
//  Card.swift
//  Set
//
//  Created by Матвей Глухов on 09.07.2024.
//

import SwiftUI

struct Card: View {
    let card: SetModel<CardContent>.Card
    
    init(card: SetModel<CardContent>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            base.stroke(.black, lineWidth: 1.5)
            VStack(spacing: 0) {
                
            }
        }
    }
}



