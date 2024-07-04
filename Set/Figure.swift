//
//  Figure.swift
//  Set
//
//  Created by Матвей Глухов on 04.07.2024.
//

import SwiftUI

struct Figure: View {
    let shapeType: String
    let numberOfSymbol: Int
    let color: Color
    let fill: Double
    
    var body: some View {
        ZStack {
            Group {
                switch shapeType {
                case "Circle":
                    Circle()
                        .stroke(color, lineWidth: 2)
                    Circle()
                        .foregroundStyle(color)
                        .opacity(fill)
                    
                case "Capsule":
                    Capsule()
                        .stroke(color, lineWidth: 2)
                    Capsule()
                        .foregroundStyle(color)
                        .opacity(fill)
                case "RoundedRectangle":
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(color, lineWidth: 2)
                    RoundedRectangle(cornerRadius: 5)
                        .foregroundStyle(color)
                        .opacity(fill)
                default:
                    Circle()
                }
            }
            //TODO: доделать
//            .minimumScaleFactor(0.01)
//            .aspectRatio(1, contentMode: .fit)
            .foregroundStyle(color)
            .padding(6)
        }
    }
    
    init(color: String, numberOfSymbol: String, shapeType: String, fill: String) {
        switch color {
        case "Red":
            self.color = .red
        case "Green":
            self.color = .green
        case "Blue":
            self.color = .blue
        default:
            self.color = .black
        }
        
        switch numberOfSymbol {
        case "One":
            self.numberOfSymbol = 1
        case "Two":
            self.numberOfSymbol = 2
        case "Three":
            self.numberOfSymbol = 3
        default:
            self.numberOfSymbol = 4
        }
        
        self.shapeType = shapeType
        
        switch fill {
        case "Fill":
            self.fill = 1
        case "Empty":
            self.fill = 0
        case "Shade":
            self.fill = 0.5
        default:
            self.fill = 0.88
        }
        
        
    }
}
