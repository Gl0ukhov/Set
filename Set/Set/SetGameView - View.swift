//
//  SetGameView .swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

struct SetGameView : View {
    var viewModel: SetGameViewModel
    
    var body: some View {
        VStack {
            header
            cards
            newGame
        }
    }
    
    var header: some View {
        Text("Set")
            .font(.title)
            .padding()
    }
    
    var cards: some View {
        AspectVGrid(viewModel.card, aspectRatio: 2/3) { card in
            Card(card: card)
                .padding(3)
        }
    }
    
    var newGame: some View {
        Button("New game") {
        }
        .padding()    }
}

struct Card: View {
    let card: SetModel.Card
    
    init(card: SetModel.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 10)
            base
                .stroke(.black, lineWidth: 1.5)
            VStack(spacing: 0) {
                switch card.numberOfSymbol {
                case "One":
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                case "Two":
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                case "Three":
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                default:
                    Figure(color: card.color, numberOfSymbol: card.numberOfSymbol, shapeType: card.shapeType, fill: card.fill)
                }
                
            }
        }
    }
}



#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
