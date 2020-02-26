//
//  Color+Extension.swift
//  ShoppingList
//
//  Created by Victor Vasconcelos on 25/02/20.
//  Copyright © 2020 Victors. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    public static var customOrange = Color("orange")
    public static var customRed = Color("red")
    public static var customDarkRed = Color("darkRed")
    public static var customPurple = Color("purple")
    public static var customPink = Color("pink")
    public static var customGreen = Color("green")
    
    public static func getProgressColor(_ progress: Float) -> Color{
        if (progress <= 0.5) {
            return .customGreen
        } else if (progress <= 0.7) {
            return .customOrange
        } else if (progress <= 0.99) {
            return .customRed
        }
        return .customDarkRed
    }
}
