//
//  HomeExpenseView.swift
//  MyExpenses
//
//  Created by Nathan Batista on 14/02/23.
//

import SwiftUI
import RealmSwift
import FirebaseAnalytics

struct HomeExpenseView: View {
    
    enum Constants {
        static let plusImageSize: CGFloat = 10
        static let textColor = Color(UIColor.label)
        static let plusImageName = "plus"
        static let listBackground = Color.cyan.opacity(0.7)
        static let plusButtonColor = Color.cyan
    }
    
    @ObservedObject var viewModel: HomeViewModel
    
    var toolbarAddItem: some View {
        Button {
            viewModel.showAddExpense.toggle()
            Analytics.logEvent("tap_add_expense", parameters: nil)
        } label: {
            Image(systemName: Constants.plusImageName)
                .frame(width: Constants.plusImageSize, height: Constants.plusImageSize)
                .foregroundColor(Constants.textColor)
                .padding()
                .background(
                    Circle()
                        .fill(Constants.plusButtonColor)
                )
        }
    }
    
    var itemsList: some View {
        List {
            ForEach(viewModel.listItem) {
                ExpenseRow(item: $0)
            }.onDelete(perform: self.viewModel.removeItem)
        }
        .scrollContentBackground(.hidden)
    }
    
    var emptyView: some View {
        ZStack(alignment: .center) {
            Text("The list is empty!")
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading")
                } else {
                    VStack {
                        VStack {
                            Text("Legenda")
                                .font(.title2)
                                .fontWeight(.bold)
                            HStack {
                                ForEach(Array(PriceColorHandler.defaultItem), id: \.title) { item in
                                    getLegendItem(item.title, item.color)
                                }
                            }
                        }
                        Spacer(minLength: 0)
                        ZStack {
                            itemsList
                                .opacity(viewModel.listItem.isEmpty ? 0 : 1)
                                .searchable(text: $viewModel.searchText)
                                .searchScopes($viewModel.expenseScope) {
                                    ForEach(ExpenseType.allCases, id: \.self) {
                                        Text("\($0.rawValue.capitalized)")
                                    }
                                }
                            emptyView
                                .opacity(viewModel.listItem.isEmpty ? 1 : 0)
                        }
                        
                        Spacer(minLength: 0)
                    }
                    .modifier(ViewBackgroundModifier(backgroundColor: Constants.listBackground))

                }
            }
            .navigationTitle("Expenses List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    toolbarAddItem
                }
            }
            .onAppear {
                Analytics.logEvent("home_view", parameters: nil)
            }
        }
        .sheet(isPresented: $viewModel.showAddExpense) {
            let addViewModel = AddExpenseViewModel(delegate: self.viewModel)
            AddExpenseView(viewModel: addViewModel)
        }
    }
    
    @ViewBuilder func getLegendItem(_ key: String, _ color: Color) -> some View {
        HStack {
            Circle()
                .fill(color)
                .frame(width: 10, height: 10)
            Text(key)
                .fontWeight(.semibold)
        }
    }
}

struct HomeExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        HomeExpenseView(viewModel: HomeViewModel())
    }
}





