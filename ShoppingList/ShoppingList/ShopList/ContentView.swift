//
//  ContentView.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 24/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [],
                  predicate: NSPredicate(format: "price == 0"))
    var itemsWithoutPrice: FetchedResults<Item>
    
    @FetchRequest(entity: Item.entity(), sortDescriptors: [],
                  predicate:  NSPredicate(format: "price != 0"))
    var itemsWithPrice: FetchedResults<Item>
    
    @State var shouldAddItem = false
    var shopListTotal: Float {
        var result: Float = 0
        for item in itemsWithPrice {
            result += item.getItemTotal()
        }
        return result
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: CustomHeader(text: "No price")) {
                        ListItemView(fetchedResults: itemsWithoutPrice) {
                            self.shouldAddItem = true
                        }
                    }
                    Section(header: CustomHeader(text: "With price")) {
                        ListItemView(fetchedResults: itemsWithPrice) {
                            self.shouldAddItem = true
                        }
                    }
                }
                TotalPopUpView(total: shopListTotal) {
                    for item in self.itemsWithPrice {
                        self.managedObjectContext.delete(item)
                    }
                    for item in self.itemsWithoutPrice {
                        self.managedObjectContext.delete(item)
                    }
                }
                .padding()
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

struct ListItemView: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    var fetchedResults: FetchedResults<Item>
    
    var clickOnCellDelegate: (()-> Void)?

    var body: some View {
        ForEach(fetchedResults) { item in
            ItemCell(item: item) {
                self.clickOnCellDelegate?()
            }
        }
        .onDelete { indexSet in
            for index in indexSet {
                self.managedObjectContext.delete(self.fetchedResults[index])
            }
        }
    }
}

struct CustomHeader: View {
    
    var text: String
    
    var body: some View {
        
        HStack {
            Text(text)
                .font(.headline)
                .foregroundColor(.white)
                .padding(5)
            Spacer()
        }
        .background(Color.customOrange)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
