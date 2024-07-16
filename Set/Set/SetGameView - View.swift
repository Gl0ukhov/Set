//
//  SetGameView .swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

struct SetGameView : View {
    let viewModel: SetGameViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                cards
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.cancelSelection()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("New game") {
                        
                    }
                }
            }
        }
    }
    
    var header: some View {
        Text("Set")
            .font(.title)
    }
    
    var cards: some View {
        AspectVGrid(viewModel.cards, aspectRatio: 2/3) { card in
            Card(card: card)
                .padding(3)
                .onTapGesture {
                    viewModel.choose(card)
                    viewModel.test()
                }
        }
    }
    
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
