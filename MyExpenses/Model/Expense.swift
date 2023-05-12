//
//  Expense.swift
//  MyExpenses
//
//  Created by Nathan Batista on 13/02/23.
//

import Foundation
import RealmSwift

enum ExpenseType: String, CaseIterable, Identifiable {
    case entertainment = "Lazer"
    case business = "Negócios"
    case needs = "Necessidades"
    case food = "Alimento"
    
    var id: Self {self}
}

class Expense: Object, ObjectKeyIdentifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var expenseName: String
    @Persisted var value: Int
    @Persisted var expenseType: String
    @Persisted var createdAt: Date
    
    var formattedValue: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        let doubleValue = Double(value)/100
        return formatter.string(from: NSNumber(floatLiteral: doubleValue)) ?? "NaN"
    }
    
    
    convenience init(expenseName: String, value: Int, expenseType: String) {
        self.init()
        self.expenseName = expenseName
        self.value = value
        self.expenseType = expenseType
        self.createdAt = Date()
    }
}
