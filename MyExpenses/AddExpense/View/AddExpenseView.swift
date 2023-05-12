//
//  AddExpenseView.swift
//  MyExpenses
//
//  Created by Nathan Batista on 13/02/23.
//

import SwiftUI
import UIKit
import Combine

struct AddExpenseView: View {
    
    enum Constants {
        //Text Constants
        static let expenseNameTitle = "Write here your expense name: "
        static let expenseCostTitle = "Write here your expense cost"
        static let expenseTypeTitle = "Choose your expense type:"
        
        //Colors
        static let textFieldBackGroundColor = Color(UIColor.tertiarySystemBackground)
        static let textColor = Color(UIColor.label)
        static let textFieldBorder = Color.black.opacity(0.5)
        static let pickerBackground = Color(UIColor.secondarySystemBackground)
        static let pickerTextColor = Color.black
        
        //Number Constants
        static let textFieldPadding: CGFloat = 6
        static let defaultStackSpacing: CGFloat = 16
        static let innerStackSpacing: CGFloat = 4
        static let currencyFieldHeight: CGFloat = 40

    }
    
    @StateObject var viewModel: AddExpenseViewModel
    @Environment(\.dismiss) var dismiss
    
    var nameLabel: some View {
        VStack(alignment: .leading, spacing: Constants.innerStackSpacing) {
            Text(Constants.expenseNameTitle)
                .foregroundColor(Constants.textColor)
            TextField("", text: $viewModel.expenseName)
                .padding(Constants.textFieldPadding)
                .background(Constants.textFieldBackGroundColor)
                .addBorder(Constants.textFieldBorder)
        }
    }
    
    var currencyField: some View {
        VStack(alignment: .leading, spacing: Constants.innerStackSpacing) {
            Text(Constants.expenseCostTitle)
                .foregroundColor(Constants.textColor)
            CurrencyTextField(numberFormatter: viewModel.currencyFormatter, value: $viewModel.expenseCost)
                .frame(height: Constants.currencyFieldHeight)
                .padding(.trailing, 8)
                .background(Constants.textFieldBackGroundColor)
                .addBorder(Constants.textFieldBorder)
        }
    }
    
    var toolbarView: some View {
        Button("Create", role: .none) {
            if viewModel.addItem() {
                dismiss()
            }
        }
        .fontWeight(.bold)
        .foregroundColor(.blue)
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading,spacing: Constants.defaultStackSpacing) {
                nameLabel
                HStack {
                    Text(Constants.expenseTypeTitle)
                        .fixedSize(horizontal: true, vertical: false)
                    Spacer()
                    Picker("Type", selection: $viewModel.expenseType) {
                        ForEach(ExpenseType.allCases) { expenseType in
                            Text(expenseType.rawValue).tag(expenseType)
                                .minimumScaleFactor(0.4)
                        }
                    }
                    .pickerStyle(.menu)
                    //Changes the color o the text
                    .tint(Constants.pickerTextColor)
                    .background(Constants.pickerBackground)
                    .cornerRadius(15)
                }
                currencyField
                Spacer()
            }
            .padding()
            .addGradient(LinearGradient(colors: [.green, .cyan, .blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            //.modifier(ViewBackgroundModifier(backgroundColor: .cyan.opacity(0.7)))
            .navigationTitle("Create Expense")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    toolbarView
                }
            }
        }

        
    }
}

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView(viewModel: AddExpenseViewModel())
    }
}

