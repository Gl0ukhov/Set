//
//  SetGameView .swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

struct SetGameView : View {
    let viewModel: SetGameViewModel
    
    private let aspectRatio: CGFloat = 2/3
    private let paddingCard: CGFloat = 3
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                cards
                    .animation(.default, value: viewModel.cards)
                button
            }
            
            .toolbarColorScheme(.dark)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        viewModel.cancelSelection()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("New game") {
                        viewModel.newGame()
                    }
                }
            }
        }
    }
    
    var header: some View {
        Text("Set")
            .font(.title)
    }
    
    var button: some View {
        Button("Give me 3 cards") {
            viewModel.giveCards()
        }
        .padding()
        .disabled(viewModel.disableadButton)
        
    }
    
    var cards: some View {
        UniversalVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            Card(card: card)
                .padding(paddingCard)
                .onTapGesture {
                    // Объединить в одну функцию, не вызывая несколько раз функции 
                    viewModel.chooseCard(card)
                    viewModel.checkMatch()
                    viewModel.remove()
                }
        }
    }
    
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
