//
//  Card.swift
//  Set
//
//  Created by Матвей Глухов on 09.07.2024.
//

import SwiftUI

struct Card: View {
    
    let card: SetModel<CardContent>.Card
    var faceDown: Double = 0
    
    init(card: SetModel<CardContent>.Card, faceDown: Double = 0) {
        self.card = card
        self.faceDown = faceDown
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
                .opacity(faceDown)
            
            base.stroke(.green)
                .overlay(Checkmark(animation: card.match) )
                .opacity(card.match == .correctly ? 1 : 0)
            
            
            base.stroke(.red)
                .overlay(Xmark(animation: card.match) )
                .opacity(card.match == .wrong ? 1 : 0)
            
        }
    }
    
    
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10
        static let padding: CGFloat = 5
    }
    
    private struct Checkmark: View {
        
        var animation: SetModel<CardContent>.Card.CardStatus
        
        var body: some View {
            Image(systemName: animation == .correctly ? "checkmark" : "circles.hexagongrid.fill")
                .font(.title)
                .bold()
                .foregroundStyle(.green)
                .symbolEffect(.bounce, value: animation)
                .contentTransition(.symbolEffect(.replace))
        }
        
    }
    
    
    private struct Xmark: View {
        
        var animation: SetModel<CardContent>.Card.CardStatus
        
        var body: some View {
            Image(systemName: "xmark")
                .font(.title)
                .bold()
                .foregroundStyle(.red)
                .symbolEffect(.pulse, options: .repeat(3).speed(3), value: animation)
        }
    }
}


#Preview {
    Card(card: SetModel<CardContent>.Card(contentCard: CardContent(shape: .Circle, number: 1, shading: 1, color: .red)))
}
