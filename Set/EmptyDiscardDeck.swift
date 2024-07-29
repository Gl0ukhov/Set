//
//  EmptyDiscardDeck.swift
//  Set
//
//  Created by Матвей Глухов on 29.07.2024.
//

import SwiftUI

struct EmptyDiscardDeck: View {
    var body: some View {
        let base = RoundedRectangle(cornerRadius: Constants.cornerRadius)
        base.fill(.white).stroke(.black, lineWidth: 1.5)
            
    }
    
    private struct Constants {
        static let cornerRadius: CGFloat = 10
    }
}


#Preview {
    EmptyDiscardDeck()
}
