//
//  PriceHandlers.swift
//  MyExpenses
//
//  Created by Nathan Batista on 14/02/23.
//

import Foundation
import SwiftUI

struct PriceColors {
    let title: String
    let color: Color
}

struct PriceColorHandler {
    enum Constants {
        static let cheapColor = Color(UIColor.systemGreen)
        static let mediumPriceColor = Color(UIColor.systemYellow)
        static let expensePriceColor = Color(UIColor.systemRed)
    }
    
    static let defaultItem: [PriceColors] = [
        PriceColors(title: "Cheap", color: Constants.cheapColor),
        PriceColors(title: "Medium", color: Constants.mediumPriceColor),
        PriceColors(title: "Expensive", color: Constants.expensePriceColor)
    ]
    
    static func getColor(price: Int) -> Color {
        let newPrice = price/100
        switch newPrice {
            case 0..<500:
                return Constants.cheapColor
            case 50..<1000:
                return Constants.mediumPriceColor
            default:
                return Constants.expensePriceColor
        }
    }
}
