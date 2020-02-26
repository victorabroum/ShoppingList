//
//  Item+CoreDataProperties.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 24/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//
//

import Foundation
import CoreData


extension Item : Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var amount: Int16
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var price: Float
    
    public func getItemTotal() -> Float {
        return Float(amount) * price
    }
    
    public static var itemVizualizer: Item {
        let item = Item()
        item.name = ["Lasanha", "Ovos", "Nescau"].randomElement() ?? "Pirulito"
        item.amount = Int16.random(in: 1...10)
        item.price = Float.random(in: 2.0...10.0)
        return item
    }
    
    public static var itemListVizualizer: [Item] = [
        Item.itemVizualizer,
        Item.itemVizualizer,
        Item.itemVizualizer,
        Item.itemVizualizer,
        Item.itemVizualizer,
        Item.itemVizualizer
    ]

}
