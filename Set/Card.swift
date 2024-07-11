//
//  Card.swift
//  Set
//
//  Created by Матвей Глухов on 09.07.2024.
//

import SwiftUI

struct Card: View {
    
    let card: SetModel<CardContent>.Card
    let viewModel: SetGameViewModel
    
    init(card: SetModel<CardContent>.Card, viewModel: SetGameViewModel) {
        self.card = card
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            base.stroke(.black, lineWidth: 1.5)
            viewModel.chooseFigure(card.contentCard.shape, number: card.contentCard.number)
                
        }
    }
    
}



