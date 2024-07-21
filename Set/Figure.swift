//
//  Figure.swift
//  Set
//
//  Created by Матвей Глухов on 11.07.2024.
//

import SwiftUI

struct Figure: ViewModifier {
    let figure: CardContent.Figure
    let quantity: Int
    let color: Color
    let shading: Double
    
   
    func body(content: Content) -> some View {
        VStack {
            ForEach(0..<quantity, id: \.self) { _ in
                switch figure {
                case .Circle:
                    self.fillAndStroke(Circle(), shading: shading, color: color)
                case .Rectangle:
                    self.fillAndStroke(Rectangle(), shading: shading, color: color)
                case .Rhomb:
                    self.fillAndStroke(Rhomb(), shading: shading, color: color)
                    
                }
            }
            .aspectRatio(Constants.aspectRatio, contentMode: .fit)
        }
    }
    
    func fillAndStroke(_ shape: some Shape, shading: Double, color: Color) -> some View {
        ZStack {
            shape.fill(color)
                .opacity(shading)
            shape.stroke(color)
        }
    }
    
    
    private struct Constants {
        static let aspectRatio: CGFloat = 2/1
    }
}

extension View {
    func figure(_ figure: CardContent.Figure, quantity: Int, color: Color, shading: Double) -> some View {
        modifier(Figure(figure: figure, quantity: quantity, color: color, shading: shading))
    }
}


