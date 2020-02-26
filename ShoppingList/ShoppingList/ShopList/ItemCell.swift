//
//  ItemCell.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 25/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import SwiftUI

struct ItemCell: View {
    
    var item: Item
    
    var delegate: (() -> Void)?
    
    var body: some View {
        Button(action: {
            AddItemSheet.item = self.item
            self.delegate?()
        }) {
            ZStack {
                HStack(alignment: .center) {
                    Text("\(item.amount)")
                    .font(.largeTitle)
                        .padding()
                    VStack(alignment: .leading) {
                        Text("\(item.name)")
                            .font(.title)
                        Text("\(item.price.getCurrency() ?? "")")
                            .font(.subheadline)
                    }
                }.frame(minWidth: 0, maxWidth: .infinity, maxHeight: .infinity, alignment: Alignment.leading)
            }
        }
    }
}

struct ItemCell_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemCell(item: Item.itemVizualizer)
        }
        .previewLayout(.fixed(width: 300, height: 100))
    }
}
