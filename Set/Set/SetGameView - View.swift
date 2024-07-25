//
//  SetGameView .swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

struct SetGameView : View {
    typealias Cards = SetModel<CardContent>.Card
    
    let viewModel: SetGameViewModel
    
    private let aspectRatio: CGFloat = 2/3
    private let paddingCard: CGFloat = 3
    private let deckWidth: CGFloat = 40
    
    @State private var dumpStack = Set<Cards.ID>()
    
    private var discardedCards: [Cards] {
        viewModel.cards.filter {  isDiscard($0) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                cards
                    .animation(.default, value: viewModel.cards)
                
                HStack(/*spacing: 0*/) {
                    button
                    Spacer()
                    discard
                }
                .padding(20)
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
    
    private var header: some View {
        Text("Set")
            .font(.title)
    }
    
    private var button: some View {
        Button("Give me 3 cards") {
            viewModel.giveCards()
        }
        .padding()
        .disabled(viewModel.disableadButton)
        
    }
    
    private var cards: some View {
        UniversalVGrid(viewModel.cards, aspectRatio: aspectRatio) { card in
            if !isDiscard(card) {
                Card(card: card)
                    .padding(paddingCard)
                    .onTapGesture {
                        viewModel.chooseCard(card)
                        viewModel.checkMatch()
                        viewModel.remove { index in
                            dumpStack.insert(viewModel.cards[index].id)
                            print("i")
                        }
                    }
            }
        }
    }
    
    private var discard: some View {
        ZStack {
            ForEach(discardedCards) { card in
                Card(card: card)
            }
            .frame(width: 40, height: deckWidth / aspectRatio)
        }
    }
    
    private func isDiscard(_ card: Cards) -> Bool {
        dumpStack.contains(card.id)
    }
    
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
