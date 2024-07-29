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
            let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
            base.fill(.white).stroke(card.selected ? .yellow : .black, lineWidth: card.selected ? 2.5 : 1.5)
                .overlay(
                    figure(card.contentCard.shape, quantity: card.contentCard.number, color: card.contentCard.color, shading: card.contentCard.shading)
                        .padding(Constants.padding)
                )
                
                .opacity(card.match == .nChecked ? 1 : 0)
            
            base.fill(.gray).stroke(.black, lineWidth: 1.5)
                .overlay(
                    Image(systemName: "questionmark")
                        .font(.system(.largeTitle))
                        .bold()
                        .foregroundStyle(.white)
                )
                .opacity(card.cardOpen ? 1 : 0)
            
            
            base.stroke(.green)
                .overlay(
                    Image(systemName: "checkmark")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.green)
                )
                .opacity(card.match == .correctly ? 1 : 0)
            
            base.stroke(.red)
                .overlay(
                    Image(systemName: "xmark")
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.red)
                )
                .opacity((card.match == .wrong ? 1 : 0))
            
        }
    }
    
    
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 5
    }
}


#Preview {
    Card(card: SetModel<CardContent>.Card(contentCard: CardContent(shape: .Circle, number: 1, shading: 1, color: .red), cardOpen:  true, id: 1001))
}
