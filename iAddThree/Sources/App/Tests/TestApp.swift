//
//  TestApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import SwiftUI

struct TestApp: App {
    private let requiresAppLaunch: Bool
    private let skipSplashScreen: Bool
    
    init() {
        skipSplashScreen = ProcessInfo.skipSplashScreen
        requiresAppLaunch = ProcessInfo.requiresAppLaunch
        
        if requiresAppLaunch{
            let defaults = UserDefaults.testingSuite()
            defaults.removePersistentDomain(forName: "uiTestingUserDefaults")
            
            if ProcessInfo.removeAds {
                defaults.set(true, forKey: AppStorageKey.adsRemoved)
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if requiresAppLaunch {
                Group {
                    if skipSplashScreen {
                        MainFeaturesCoordinatorView(viewModel: .customInit())
                    } else {
                        LaunchCoordinatorView()
                    }
                }
                .withErrorHandling()
            } else {
                Text("Running Unit Tests")
            }
        }
    }
}
