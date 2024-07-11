//
//  SetGame - ViewModel.swift
//  Set
//
//  Created by Матвей Глухов on 25.06.2024.
//

import SwiftUI

@Observable
class SetGameViewModel {
    typealias Card = SetModel<CardContent>.Card
    typealias Model = SetModel<CardContent>
    
    private var model: Model
        
    init() {
        model = SetGameViewModel.createSetGame()
    }
    
    private static func createSetGame() -> Model {
        var cardsContent = [CardContent]()
        
        for shape in CardContent.Figure.allCases {
            for number in CardContent.allNumber {
                for shading in CardContent.allShading {
                    for color in CardContent.allColor {
                        let card = CardContent(shape: shape, number: number, shading: shading, color: color)
                        cardsContent.append(card)
                    }
                }
            }
        }
        return SetModel(cardsContent)
    }
    
    
    var cards: [Card] {
        model.cards
    }
    
    func newGame() {
        model = SetGameViewModel.createSetGame()
    }
    
    func giveCards() {

    }
    
    func chooseFigure(_ figure: CardContent.Figure, number: Int) -> some View {
        VStack {
            ForEach(0..<number, id: \.self) { _ in
                switch figure {
                case .Circle:
                    self.fillAndStroke(shape: Circle())
                case .Rectangle:
                    Rectangle()
                case .Rhomb:
                    Rhomb()
                }
            }
        }
    }
    
    func fillAndStroke(shape: some Shape) -> some View {
        ZStack {
            shape.fill(.red)
                .opacity(0)
            shape.stroke(.red)
        }
    }
    
}


