//
//  ItemsViewModel.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 26/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import Foundation
import Combine
import CoreData

class ItemsViewModel: ObservableObject {
    
    let didChange = PassthroughSubject<ItemsViewModel, Never>()
    
    var allItems = [Item]() {
        didSet {
            didChange.send(self)
        }
    }
    
    private func fecthAllItems() {
        let context = AppDelegate().persistentContainer.viewContext
        
        let fecthRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Item")
        
        do {
            let result = try context.fetch(fecthRequest)
            for data in result {
                if let item = data as? Item {
                    allItems.append(item)
                }
            }
        } catch {
            print("Not possible do fecth")
        }
    }
    
}
