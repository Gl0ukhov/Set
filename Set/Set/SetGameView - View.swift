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
            Spacer()
            ScrollView {
                cards
            }
            Spacer()
            newGame
        }
    }
    
    var header: some View {
        Text("Set")
            .font(.title)
            .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 95), spacing: 0)], content: {
            ForEach(viewModel.card) { card in
                Card(card: card)
            }
            
        })
    }
    
    var newGame: some View {
        Button("New game") {
        }
        .padding()
    }
}

struct Card: View {
    let card: SetModel.Card
    
    init(card: SetModel.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25.0)
                .strokeBorder(style: StrokeStyle(lineWidth: 1))
            
            Text(card.figure)
//                .strokeBorder(style: StrokeStyle())
                .padding()
                .foregroundStyle(.red)
                .opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                
        }
        .padding(5)
    }
}

#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
