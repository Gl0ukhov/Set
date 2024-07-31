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
    
    // Набор сброшенных карт
    @State private var dumpStack = Set<Cards.ID>()
    
    // Набор открытых карт
    @State private var openCard = Set<Cards.ID>()
    
    // Массив сброшенных карт
    private var discardedCards: [Cards] {
        viewModel.cards.filter {  isDiscard($0) }
    }
    
    // Массив открытых карт
    private var openedCard: [Cards] {
        viewModel.cards.filter { isOpen($0) }
    }
    
    
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
                    startCards.forEach { openCard.insert($0.id)}
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
                        viewModel.newGame {  startCards in
                            startCards.forEach { openCard.insert($0.id)}
                        }
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
                    Card(card: card, faceDown: 1)
                        .matchedGeometryEffect(id: card.id, in: cardResetNamespace)
                        .transition(.asymmetric(insertion: .identity, removal: .identity))
                }
            }
        }
        // MARK: Добавить смещение для карт
        .frame(width: 40, height: deckWidth / aspectRatio)
        .opacity(viewModel.disableadButton ? 0 : 1)
        .animation(.smooth, value: viewModel.disableadButton)
        .onTapGesture {
            viewModel.giveCards(insert: {  cardOpen in
                var delay: TimeInterval = 0
                for card in cardOpen {
                    withAnimation(dealAnimation.delay(delay)) {
                        let _ = openCard.insert(card.id)
                    }
                    delay += dealInterval
                }
            }, remove: { cardRemove in
                var delay: TimeInterval = 0
                for card in cardRemove {
                    withAnimation(dealAnimation.delay(delay)) {
                        let _ = dumpStack.insert(card.id)
                    }
                    delay += dealInterval
                }
            })
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
