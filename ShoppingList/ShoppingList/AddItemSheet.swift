//
//  AddItemSheet.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 24/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import SwiftUI

struct AddItemSheet: View {
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode
    
    @State var amount = 1;
    @State var name = ""
    @State var price: String = ""
    @State var textButtonNewItem: String = "Add item"
    
    static var item: Item?
    
    private var intFormatter: NumberFormatter {
        let formater = NumberFormatter()
        formater.allowsFloats = false
        return formater
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section() {
                    TextField("Name", text: $name)
                    Stepper("\(amount) item", value: $amount,in: 1...50)
                }
                
                Section(header: Text("Do you khown the price?")) {
                    TextField("Price", text: $price)
                        .keyboardType(.decimalPad)
                }
                
                Button(action: {
                    self.addNewItem(AddItemSheet.item)
                }, label: {
                    Text(textButtonNewItem)
                })
                .navigationBarTitle(textButtonNewItem)
            }
        }.onAppear {
            self.chooseItem(AddItemSheet.item)
        }.onDisappear {
            AddItemSheet.item = nil
        }
    }
    
    public func chooseItem(_ item: Item?) {
        if let item = item {
            name = item.name
            price = "\(item.price)"
            amount = Int(item.amount)
            textButtonNewItem = "Edit item"
        }
    }
    
    private func addNewItem(_ item: Item?) {
        guard name != "" else { return }
        
        var newItem: Item
        
        if item == nil {
            newItem = Item(context: self.managedObjectContext)
        } else {
            newItem = item!
        }
        
        newItem.name = name
        newItem.amount = Int16(amount)
        
        if let priceValue = Float(price.replacingOccurrences(of: ",", with: ".")) {
            newItem.price = priceValue
        }
        
        newItem.id = UUID()
        
        do {
            try self.managedObjectContext.save()
            self.presentationMode.wrappedValue.dismiss()
            print("Saved new item")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct AddItemSheet_Previews: PreviewProvider {
    static var previews: some View {
        AddItemSheet()
    }
}
