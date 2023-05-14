//
//  AppDelegate.swift
//  MyExpenses
//
//  Created by Nathan Batista de Oliveira on 14/05/23.
//

import UIKit
import FirebaseCore
import FirebaseCrashlytics
import FirebaseAnalytics

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.getFirebaseConfig()
        return true
    }
    
    private func getFirebaseConfig() {
        if let configurationPath = Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist"), let options = FirebaseOptions(contentsOfFile: configurationPath) {
            FirebaseApp.configure(options: options)
        }
    }
}
