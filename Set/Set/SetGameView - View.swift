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
    
    let viewModel: SetGameViewModel
    
    private let aspectRatio: CGFloat = 2/3
    private let paddingCard: CGFloat = 3
    private let deckWidth: CGFloat = 40
    private let dealAnimation: Animation = .easeOut(duration: 1)
    private let dealInterval: TimeInterval = 0.1
    
    // Набор удаленных карт
    @State private var dumpStack = Set<Cards.ID>()
    
    // Набор карт на экране
    @State private var openCard = Set<Cards.ID>()
    
    // Фильтр для выдачи удаленных карт
    private var discardedCards: [Cards] {
        viewModel.cards.filter {  isDiscard($0) }
    }
    
    // Набор открытых карт
    private var openedCard: [Cards] {
        viewModel.cards.filter { isOpen($0) }
    }
    
    @State private var rotatingCardID: Cards.ID?
    
    
    var body: some View {
        NavigationStack {
            VStack {
                header
                cards
                HStack {
                    deck
                    Spacer()
                    discard
                }
                .padding(20)
            }
            .onAppear(perform: {
                viewModel.startGame { startCards in
                    for card in startCards {
                        openCard.insert(card.id)
                        
                    }
                }
            })
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
    
    
    // Отображение карт на главном экране
    private var cards: some View {
        UniversalVGrid(viewModel.startCards, aspectRatio: aspectRatio) { card in
            if !isDiscard(card) && isOpen(card) {
                Card(card: card)
                    .matchedGeometryEffect(id: card.id, in: cardResetNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .padding(paddingCard)
                    .onTapGesture {
                        viewModel.chooseCard(card)
                        viewModel.checkMatch()
                        viewModel.remove { cardRemove in
                            var delay: TimeInterval = 0
                            for card in cardRemove {
                                withAnimation(dealAnimation.delay(delay)) {
                                    let _ = dumpStack.insert(card.id)
                                }
                                delay += dealInterval
                            }
                        }
                        
                    }
            }
        }
        .animation(.default, value: viewModel.startCards)
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
        .frame(width: 40, height: deckWidth / aspectRatio)
    }
    
    // Отображение колоды карт
    private var deck: some View {
        ZStack {
            ForEach(viewModel.cards) { card in
                if !isOpen(card) {
                    Card(card: card, rotation: 0)
                        .matchedGeometryEffect(id: card.id, in: cardResetNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
        }
        .frame(width: 40, height: deckWidth / aspectRatio)
        .opacity(viewModel.disableadButton ? 0 : 1)
        .animation(.smooth, value: viewModel.disableadButton)
        .onTapGesture {
            viewModel.giveCards { cardOpen in
                var delay: TimeInterval = 0
                for card in cardOpen {
                    withAnimation(dealAnimation.delay(delay)) {
                        let _ = openCard.insert(card.id)
                    }
                    delay += dealInterval
                }
            }
        }
    }
    
    // Проверка сброшена ли карта
    private func isDiscard(_ card: Cards) -> Bool {
        dumpStack.contains(card.id)
    }
    
    // Проверка открыта ли карта
    private func isOpen(_ card: Cards) -> Bool {
        openCard.contains(card.id)
    }
}




#Preview {
    SetGameView(viewModel: SetGameViewModel())
}
