//
//  GameKitSocialPerformanceStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import iAddThreeCore

final class GameKitSocialPerformanceStore: SocialPerformanceStore {
    func loadHighScore(modeId: String) async -> Int? {
        return await SharedGameKitManager.loadHighScore(leaderboardId: modeId)
    }
    
    func loadUnlockedAchievements(modeId: String) async -> [GameAchievement] {
        return []
    }
    
    func saveHighScore(_ newHighScore: Int, modeId: String) {
        SharedGameKitManager.saveHighScore(score: newHighScore, leaderboardId: modeId)
    }
    
    func saveAchievements(_ achievements: [GameAchievement]) {
        SharedGameKitManager.reportAchievementList(idList: achievements.map({ $0.identifier }))
    }
}
