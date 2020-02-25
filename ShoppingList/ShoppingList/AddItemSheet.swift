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
    @State var price:Float = 0
    
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
                    TextField("Price", value: $price, formatter: NumberFormatter())
                }
                
                Button(action: {
                    print("Add Item")
                }, label: {
                    Text("Add item")
                })
                .navigationBarTitle("Add item")
            }
        }
    }
    
    private func addNewItem(_ item: Item) {
        guard name != "" else { return }
        let newItem = Item(context: self.managedObjectContext)
        newItem.name = name
        newItem.amount = Int16(amount)
        newItem.price = price
        newItem.id = UUID()
        
        do {
            try self.managedObjectContext.save()
            self.presentationMode.wrappedValue.dismiss()
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
