//
//  MyExpensesApp.swift
//  MyExpenses
//
//  Created by Nathan Batista on 13/02/23.
//

import SwiftUI

@main
struct MyExpensesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            HomeExpenseView(viewModel: HomeViewModel())
        }
    }
}
