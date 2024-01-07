//
//  GameKitSocialPerformanceStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import iAddThreeCore

final class GameKitSocialPerformanceStore: SocialPerformanceStore {
    func loadHighScore(modeId: String) -> Int? {
        nil
    }
    
    func loadUnlockedAchievements(modeId: String) -> [GameAchievement] {
        []
    }
    
    func saveHighScore(_ newHighScore: Int, modeId: String) {
        
    }
    
    func saveAchievements(_ achievements: [GameAchievement]) {
        
    }
}
