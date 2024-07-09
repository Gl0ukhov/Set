//
//  File.swift
//  Set
//
//  Created by Матвей Глухов on 09.07.2024.
//

import Foundation

struct CardContent {
    
    enum Color: String, CaseIterable {
        case Red
        case Green
        case Blue
    }
    enum Number: String, CaseIterable {
        case one 
        case two
        case three
    }
    enum Shading: String, CaseIterable {
        case Fill
        case Empty
        case Shade
    }
    enum Shape: String, CaseIterable {
        case Circle
        case Rectangle
        case Rhomb
    }
    
    let shape: Shape
    let number: Number
    let shading: Shading
    let color: Color
    
    init(shape: Shape, number: Number, shading: Shading, color: Color) {
        self.shape = shape
        self.number = number
        self.shading = shading
        self.color = color
    }
    
}
