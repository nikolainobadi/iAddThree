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
