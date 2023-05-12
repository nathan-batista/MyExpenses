//
//  HomeViewModel.swift
//  MyExpenses
//
//  Created by Nathan Batista on 13/02/23.
//

import RealmSwift
import Combine

protocol ExpensesChanges: NSObject {
    func didAddExpense(expense: Expense)
}

class HomeViewModel: NSObject, ObservableObject, ExpensesChanges {
    
    @ObservedResults(Expense.self) var myExpenses
    @Published var showAddExpense = false
    @Published var isLoading = false
    @Published var searchText = ""
    @Published var expenseScope = ExpenseType.entertainment
    
    var cancellables = Set<AnyCancellable>()
    
    var listItem: [Expense] = [] {
        willSet {
            self.objectWillChange.send()
        }
    }
    
    override init() {
        super.init()
        self.performSearch(searchText: "", scope: .entertainment)
        
        self.$searchText.debounce(for: .milliseconds(800), scheduler: DispatchQueue.main).sink { [weak self] searchValue in
            guard let self = self else { return }
            self.performSearch(searchText: searchValue, scope: self.expenseScope)
        }.store(in: &cancellables)
        
        self.$expenseScope.sink { [weak self] type in
            guard let self = self else { return }
            self.performSearch(searchText: self.searchText, scope: type)
        }.store(in: &cancellables)
    }
    
    func didAddExpense(expense: Expense) {
        self.$myExpenses.append(expense)
        self.listItem = myExpenses.toArray()
    }
    
    func removeItem(_ offset: IndexSet) {
        self.isLoading.toggle()
        self.listItem = []
        $myExpenses.remove(atOffsets: offset)
        self.listItem = myExpenses.toArray()
        self.isLoading.toggle()
    }
    
    private func performSearch(searchText: String, scope: ExpenseType) {
        guard !searchText.isEmpty else {
            let items: [Expense] = self.myExpenses.toArray()
            self.listItem = items.filter({ $0.expenseType == scope.rawValue })
            return
        }
        let currentValues: [Expense] = self.myExpenses.toArray()
        let filteredValues = currentValues.filter({ return $0.expenseName.range(of: searchText, options: .caseInsensitive) != nil && $0.expenseType == scope.rawValue })
        self.listItem = filteredValues
    }
    
}



extension Results {
    func toArray<T>() -> [T] {
        self.compactMap({$0 as? T})
    }
}
