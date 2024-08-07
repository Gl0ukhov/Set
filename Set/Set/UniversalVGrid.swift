//
//  UniversalVGrid.swift
//  Set
//
//  Created by Матвей Глухов on 03.07.2024.
//

import SwiftUI

struct UniversalVGrid<Item: Identifiable, ItemView: View>: View {
    var items: [Item]
    
    var aspectRatio: CGFloat = 1
    var content: (Item) -> ItemView
    
    var body: some View {
        GeometryReader { geometry in
            let gridItemSize = gridItemWidthThatFits(
                count: items.count,
                size: geometry.size,
                atAspectRatio: aspectRatio
            )
            LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                ForEach(items) { item in
                    content(item)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                    
                }
            }
        }
    }
    
    init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
        self.items = items
        self.aspectRatio = aspectRatio
        self.content = content
    }
    
    private func gridItemWidthThatFits(count: Int, size: CGSize, atAspectRatio: CGFloat) -> CGFloat {
        var columnCount = 1.0
        let count = CGFloat(count)
        repeat {
            let width = size.width / columnCount
            let height = width / atAspectRatio
            let rowCount = (count / columnCount).rounded(.up)
            
            if rowCount * height < size.height {
                return (size.width / columnCount).rounded(.down)
            }
            columnCount += 1
        } while columnCount < count
        return min(size.width / CGFloat(count), size.height * atAspectRatio).rounded(.down)
    }
}
