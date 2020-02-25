//
//  ItemCell.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 25/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import SwiftUI

struct ItemVizualizer {
    var name: String
    var amount: Int16
    var price: Float
    
    public func getPriceText() -> String {
        return String(format: "R$ %.2f", self.price)
    }
}

struct ItemCell: View {
    
//    var item: ItemVizualizer
    var item: Item
    
    var body: some View {
        Button(action: {
            AddItemSheet.item = self.item
        }) {
            ZStack {
                Rectangle().foregroundColor(Color.customRed)
                HStack(alignment: .center) {
                    ZStack {
                        Rectangle().foregroundColor(Color.purple)
                        Text("\(item.amount)")
                            .font(.largeTitle)
                    }.frame(width: 70, alignment: Alignment.leading)
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                            .font(.title)
                        Text("\(item.getPriceText())")
                            .font(.subheadline)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, alignment: Alignment.leading)
            }
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
//            ItemCell(item: ItemVizualizer(name: "Lasanha", amount: 2, price: 4.5))
            ItemCell(item: Item())
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
