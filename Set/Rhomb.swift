//
//  Rhomb.swift
//  Set
//
//  Created by Матвей Глухов on 09.07.2024.
//

import SwiftUI
import CoreGraphics

struct Rhomb: Shape {
    
    func path(in rect: CGRect) -> Path {
        
        let start = CGPoint(x: rect.minX, y: rect.midY)
        let firstLine = CGPoint(x: rect.midX, y: rect.maxY)
        let secondLine = CGPoint(x: rect.maxX, y: rect.midY)
        let thirdLine = CGPoint(x: rect.midX, y: rect.minY)
        
        
        var p = Path()
        p.move(to: start)
        p.addLine(to: firstLine)
        p.addLine(to: secondLine)
        p.addLine(to: thirdLine)
        p.addLine(to: start)
        
        p.closeSubpath()
        
        return p
    }
}
