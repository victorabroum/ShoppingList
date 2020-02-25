//
//  ContentView.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 24/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import SwiftUI

struct HelperItem {
    var id: UUID
    var name: String?
    var amount: Int
    var price: Float
}

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [],
                  predicate: NSPredicate(format: "price == 0"))
    var itemsWithoutPrice: FetchedResults<Item>
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    var allItems: FetchedResults<Item>
    
    @State var shouldAddItem = false
    var shopListTotal: Float {
        var result: Float = 0
        for item in allItems {
            result += item.getItemTotal()
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(allItems) { item in
                        Button(action: {
                            AddItemSheet.item = item
                            self.shouldAddItem = true
                        }) {
                            HStack {
                                Text("\(item.amount) | \(item.name)")
                                Spacer()
                                Text("R$ \(String(format: "%.2f", item.price))")
                            }
                        }
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            self.managedObjectContext.delete(self.allItems[index])
                        }
                    }
                }
                Text("Total: \(String(format: "%.2f", shopListTotal))")
            }
            .navigationBarTitle("My itens")
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        print("Got to add Item")
                        self.shouldAddItem = true
                    }, label: {
                        Image(systemName: "plus.circle")
                        .resizable()
                            .frame(width: 32, height: 32, alignment: .center)
                    })
                })
                .sheet(isPresented: $shouldAddItem) {
                    AddItemSheet().environment(\.managedObjectContext, self.managedObjectContext)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
