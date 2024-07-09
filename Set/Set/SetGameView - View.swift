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
        AspectVGrid(viewModel.cards, aspectRatio: 2/3) { card in
            Card(card: card)
                .padding(3)
        }
    }
    
    var newGame: some View {
        Button("New game") {
        }
        .padding()    }
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
