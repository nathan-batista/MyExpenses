//
//  PriceHandlers.swift
//  MyExpenses
//
//  Created by Nathan Batista on 14/02/23.
//

import Foundation
import SwiftUI

struct PriceColorHandler {
    enum Constants {
        static let cheapColor = Color(UIColor.systemGreen)
        static let mediumPriceColor = Color(UIColor.systemYellow)
        static let expensePriceColor = Color(UIColor.systemRed)
    }
    
    struct AllPriceLegend {
        static var defaultItem: [String: Color] = [
            "Cheap": Constants.cheapColor,
            "Medium": Constants.mediumPriceColor,
            "Expensive": Constants.expensePriceColor
        ]
    }
    
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
