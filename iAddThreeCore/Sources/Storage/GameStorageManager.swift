//
//  GameStorageManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import Foundation

final class GameStorageManager {
    private let socialStore: SocialPerformanceStore
    private let performanceStore: GamePerformanceStore
    
    init(socialStore: SocialPerformanceStore, performanceStore: GamePerformanceStore) {
        self.socialStore = socialStore
        self.performanceStore = performanceStore
    }
}


// MARK: - Store
extension GameStorageManager: GameStore {
    var modeLevel: Int {
        return performanceStore.modeLevel
    }
    
    func loadUnlockedAchievements(modeId: String) -> [GameAchievement] {
        return socialStore.loadUnlockedAchievements(modeId: modeId)
    }
    
    func loadTotalCompletedLevelsCount(modeId: String) -> Int {
        return performanceStore.getTotalCompletedLevelsCount(modeId: modeId)
    }
    
    func loadHighScore(modeId: String) -> Int {
        guard let leaderboardHighScore = socialStore.loadHighScore(modeId: modeId) else {
            return performanceStore.getHighScore(modeId: modeId)
        }
            
        if leaderboardHighScore > performanceStore.getHighScore(modeId: modeId) {
            performanceStore.saveHighScore(leaderboardHighScore, modeId: modeId)
        }
        
        return leaderboardHighScore
    }
    
    func save(record: PerformanceRecord) {
        if let newHighScore = record.newHighScore {
            socialStore.saveHighScore(newHighScore, modeId: record.modeId)
            performanceStore.saveHighScore(newHighScore, modeId: record.modeId)
        }
        
        if record.shouldUnlockNextMode {
            performanceStore.incrementModeLevel()
        }
        
        socialStore.saveAchievements(record.newAchievements)
    }
}


// MARK: - Dependencies
public protocol GamePerformanceStore {
    var modeLevel: Int { get }
    
    func getHighScore(modeId: String) -> Int
    func getTotalCompletedLevelsCount(modeId: String) -> Int
    func incrementModeLevel()
    func saveHighScore(_ newHighScore: Int, modeId: String)
}

public protocol SocialPerformanceStore {
    func loadHighScore(modeId: String) -> Int?
    func loadUnlockedAchievements(modeId: String) -> [GameAchievement]
    func saveHighScore(_ newHighScore: Int, modeId: String)
    func saveAchievements(_ achievements: [GameAchievement])
}
