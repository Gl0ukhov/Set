//
//  SetGameView .swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

struct SetGameView : View {
    @Namespace private var cardResetNamespace
    
    typealias Cards = SetModel<CardContent>.Card
    
    var viewModel: SetGameViewModel
    
    private let aspectRatio: CGFloat = 2/3
    private let paddingCard: CGFloat = 3
    private let deckWidth: CGFloat = 60
    private let dealAnimation: Animation = .easeOut(duration: 1)
    
    
    // Массив сброшенных карт
    private var discardedCards: [Cards] {
        viewModel.cards.filter {  $0.status == .discard }
    }
    
    // Массив открытых карт
    private var openedCard: [Cards] {
        viewModel.cards.filter { $0.status == .open }
    }
    
    // Массив кард в колоде
    private var deckCard: [Cards] {
        viewModel.cards.filter { $0.status == .deck }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                cards
                    .padding(.horizontal, 10)
                HStack {
                    deck
                    Spacer()
                    discard
                }
                .padding(.horizontal, 50)
            }
            .preferredColorScheme(.light)
            .toolbarColorScheme(.light)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    Button("Reshuffle") {
                        viewModel.shuffle()
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
    
    // Название игры
    private var header: some View {
        Text("Set")
            .font(.title)
    }
    
    // Отображение карт в центре экрана
    private var cards: some View {
        UniversalVGrid(openedCard, aspectRatio: aspectRatio) { card in
                Card(card: card)
                    .matchedGeometryEffect(id: card.id, in: cardResetNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(paddingCard)
                    .onTapGesture {
                        viewModel.chooseCard(card)
                        viewModel.checkMatch()
                        withAnimation(dealAnimation) {
                            viewModel.remove()
                        }
                    }
        }
        .animation(.default, value: openedCard)
    }
    
    // Отображение сброшенных карт
    private var discard: some View {
        ZStack {
            if discardedCards.count == 0 {
                EmptyDiscardDeck()
            } else {
                ForEach(discardedCards) { card in
                    Card(card: card)
                        .matchedGeometryEffect(id: card.id, in: cardResetNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
    }
    
    // Отображение колоды карт
    private var deck: some View {
        ZStack {
            ForEach(deckCard) { card in
                    Card(card: card)
                        .matchedGeometryEffect(id: card.id, in: cardResetNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
            }
        }
        .frame(width: deckWidth, height: deckWidth / aspectRatio)
        .onTapGesture {

            viewModel.giveCards()
        }
    }

}


#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
