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
    
    func loadUnlockedAchievements() async -> [GameAchievement] {
        return await SharedGameKitManager.loadAchievementIds().map({ .init(identifier: $0) })
    }
    
    func saveHighScore(_ newHighScore: Int, modeId: String) {
        SharedGameKitManager.saveHighScore(score: newHighScore, leaderboardId: modeId)
    }
    
    func saveAchievements(_ achievements: [GameAchievement]) {
        SharedGameKitManager.reportAchievementList(idList: achievements.map({ $0.identifier }))
    }
}
