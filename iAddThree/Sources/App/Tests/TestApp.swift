//
//  TestApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import SwiftUI
import iAddThreeCore
import iAddThreeClassicKit

struct TestApp: App {
    private let skipSplashScreen: Bool
    private let requiresAppLaunch: Bool
    
    init() {
        skipSplashScreen = ProcessInfo.isTrue(.skipSplashScreen)
        requiresAppLaunch = ProcessInfo.isTrue(.requiresAppLaunch)
        
        if requiresAppLaunch {
            let defaults = UserDefaults.testingSuite()
            defaults.removePersistentDomain(forName: UI_USER_DEFAULTS_SUITE)
            defaults.set(ProcessInfo.isTrue(.removeAds), forKey: AppStorageKey.adsRemoved)
            
            if ProcessInfo.isTrue(.unlockedSubtractMode) {
                defaults.set(1, forKey: AppStorageKey.modeLevel)
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
