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
    
    func loadUnlockedAchievements(modeId: String) async -> [GameAchievement] {
        return await socialStore.loadUnlockedAchievements(modeId: modeId)
    }
    
    func loadTotalCompletedLevelsCount(modeId: String) -> Int {
        return performanceStore.getTotalCompletedLevelsCount(modeId: modeId)
    }
    
    func loadHighScore(modeId: String) async -> Int {
        guard let leaderboardHighScore = await socialStore.loadHighScore(modeId: modeId) else {
            return performanceStore.getHighScore(modeId: modeId)
        }
            
        if leaderboardHighScore > performanceStore.getHighScore(modeId: modeId) {
            performanceStore.saveHighScore(leaderboardHighScore, modeId: modeId)
        }
        
        return leaderboardHighScore
    }
    
    func save(record: PerformanceRecord) {
        socialStore.saveAchievements(record.newAchievements)
        unlockModes(shouldUnlockNextMode: record.shouldUnlockNextMode)
        saveHighScore(newHighScore: record.newHighScore, modeId: record.modeId)
    }
}


// MARK: - Private Methods
private extension GameStorageManager {
    func saveHighScore(newHighScore: Int?, modeId: String) {
        if let newHighScore = newHighScore {
            socialStore.saveHighScore(newHighScore, modeId: modeId)
            performanceStore.saveHighScore(newHighScore, modeId: modeId)
        }
    }
    
    func unlockModes(shouldUnlockNextMode: Bool) {
        if shouldUnlockNextMode {
            performanceStore.incrementModeLevel()
        }
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
    func loadHighScore(modeId: String) async -> Int?
    func loadUnlockedAchievements(modeId: String) async -> [GameAchievement]
    func saveHighScore(_ newHighScore: Int, modeId: String)
    func saveAchievements(_ achievements: [GameAchievement])
}
