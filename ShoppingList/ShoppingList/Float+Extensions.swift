//
//  Float+Extensions.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 26/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import Foundation

extension Float {
    public func getCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        if let numberCurrency = formatter.string(from: self as NSNumber) {
            return numberCurrency
        }
        return nil
    }
}
