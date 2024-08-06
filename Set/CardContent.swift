//
//  File.swift
//  Set
//
//  Created by Матвей Глухов on 09.07.2024.
//

import Foundation
import SwiftUI

struct CardContent: Hashable {
    
    enum Figure: String, CaseIterable {
        case Circle
        case Rectangle
        case Rhomb
    }
    
    static let allNumber: [Int] = [1, 2, 3]
    static let allShading: [Double] = [1, 0.3, 0]
    static let allColor: [Color] = [.red, .green, .blue]
    
    
    
    let shape: Figure
    let number: Int
    let shading: Double
    let color: Color
    
    init(shape: Figure, number: Int, shading: Double, color: Color) {
        self.shape = shape
        self.number = number
        self.shading = shading
        self.color = color
    }
    
}
