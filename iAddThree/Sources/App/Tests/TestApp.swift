//
//  TestApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import SwiftUI
import iAddThreeCore

struct TestApp: App {
    @State private var isTestingClassicKit: Bool
    
    private let requiresAppLaunch: Bool
    private let skipSplashScreen: Bool
    
    init() {
        skipSplashScreen = ProcessInfo.skipSplashScreen
        requiresAppLaunch = ProcessInfo.requiresAppLaunch
        _isTestingClassicKit = .init(wrappedValue: ProcessInfo.isTestingClassicKit)
        
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
                        if isTestingClassicKit {
                            GameCoordinatorView(adapter: .testInit(), endGame: { isTestingClassicKit = false })
                        } else {
                            MainFeaturesCoordinatorView(viewModel: .customInit())
                        }
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


extension ClassicResultsAdapter {
    static func testInit(mode: GameMode = .add) -> ClassicResultsAdapter {
        return .init(manager: .testInit(mode: mode))
    }
}

extension GameManager {
    static func testInit(mode: GameMode) -> GameManager {
        return .init(mode: mode, socialStore: MockSocialStore(), performanceStore: UserDefaultsGamePerformanceStore(defaults: .testingSuite()))
    }
}

class MockSocialStore: SocialPerformanceStore {
    func loadHighScore(modeId: String) async -> Int? { nil }
    func loadUnlockedAchievements() async -> [iAddThreeCore.GameAchievement] { [] }
    func saveHighScore(_ newHighScore: Int, modeId: String) { }
    func saveAchievements(_ achievements: [iAddThreeCore.GameAchievement]) { }
}
