//
//  TotalPopUpView.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 26/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import SwiftUI

struct TotalPopUpView: View {
    
    var total: Float
    
    @State private var showingAlert = false
    
    var finishDelegate: (() -> Void)?
    
    var body: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            HStack {
                Image(systemName: "cart")
                    .font(.title)
                Text("Total: \(total.getCurrency() ?? "")")
                    .fontWeight(.semibold)
                    .font(.title)
            }
            .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 45)
            .padding(1)
            .foregroundColor(.white)
            .background(Color.getProgressColor(total / 400))
            .cornerRadius(40)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Finish the shopping?"), message: Text("By saying yes, all your itens will removed!"), primaryButton: .default(Text("Okay"), action: {
                print("Pay for all and erease everything")
                self.finishDelegate?()
            }), secondaryButton: .cancel(Text("Not yet")))
        }
    }
}

struct TotalPopUpView_Previews: PreviewProvider {
    static var previews: some View {
        TotalPopUpView(total: 100)
    }
}
