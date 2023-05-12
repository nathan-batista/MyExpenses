//
//  AddExpenseViewModel.swift
//  MyExpenses
//
//  Created by Nathan Batista on 13/02/23.
//

import Foundation

class AddExpenseViewModel: ObservableObject {
    
    @Published var expenseCost = 0
    @Published var expenseName: String = ""
    @Published var expenseType: ExpenseType = ExpenseType.entertainment
    @Published var expensePrice: String = ""
    let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        return formatter
    }()
        
    weak var delegate: ExpensesChanges?
    
    init(delegate: ExpensesChanges? = nil) {
        self.delegate = delegate
    }
        
    func addItem() -> Bool {
        guard !expenseName.isEmpty, expenseCost > 0 else { return false }
        let expense = Expense(expenseName: expenseName, value: expenseCost, expenseType: self.expenseType.rawValue)
        delegate?.didAddExpense(expense: expense)
        return true
    }
}
