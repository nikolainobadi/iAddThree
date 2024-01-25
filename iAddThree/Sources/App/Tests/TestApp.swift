//
//  TestApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import SwiftUI

struct TestApp: App {
    private let requiresAppLaunch: Bool
    
    init() {
        if ProcessInfo.requiresAppLaunch {
            self.requiresAppLaunch = true
            let defaults = UserDefaults.testingSuite()
            defaults.removePersistentDomain(forName: "uiTestingUserDefaults")
            
            if ProcessInfo.removeAds {
                defaults.set(true, forKey: AppStorageKey.adsRemoved)
            }
        } else {
            self.requiresAppLaunch = false
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if requiresAppLaunch {
                LaunchCoordinatorView()
                    .withErrorHandling()
            } else {
                Text("Running Unit Tests")
            }
        }
    }
}
