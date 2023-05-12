//
//  ExpenseRow.swift
//  MyExpenses
//
//  Created by Nathan Batista on 14/02/23.
//

import SwiftUI

struct ExpenseRow: View {
    let item: Expense
//    let deleteAction: (Expense) -> Void
//
//    var deleteButton: some View {
//        Button {
//            deleteAction(item)
//        } label: {
//            Image(systemName: "trash.fill")
//        }
//        .tint(.red)
//    }
    
    var body: some View {
        HStack {
            Text(item.expenseName)
            Spacer()
            Text(item.formattedValue)
                .foregroundColor(PriceColorHandler.getColor(price: item.value))
        }
        .fontWeight(.bold)
//        .swipeActions(edge: .trailing) {
//           deleteButton
//        }
    }
}

struct ExpenseRow_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseRow(item: Expense())
    }
}
