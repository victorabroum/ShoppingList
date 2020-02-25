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
    
    @State var shouldAddItem = false
    
    var body: some View {
        NavigationView {
            List {
                Text("Sample Order")
            }
            .navigationBarTitle("My itens")
            .navigationBarItems(trailing: Button(action: {
                print("Got to add Item")
                self.shouldAddItem = true
            }, label: {
                Image(systemName: "plus.circle")
                .resizable()
                    .frame(width: 32, height: 32, alignment: .center)
            }))
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
