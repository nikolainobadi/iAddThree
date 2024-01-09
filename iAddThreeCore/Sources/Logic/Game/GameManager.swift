//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

public final class GameManager {
    @Published public var currentHighScore: Int = 0

    public let mode: GameMode
    private let store: GameStore

    private var unlockedAchievements: [GameAchievement] = []
    
    init(mode: GameMode, store: GameStore) {
        self.mode = mode
        self.store = store
        self.loadData()
    }
}


// MARK: - Convenience init
public extension GameManager {
    convenience init(mode: GameMode, socialStore: SocialPerformanceStore, performanceStore: GamePerformanceStore) {
        self.init(mode: mode, store: GameStorageManager(socialStore: socialStore, performanceStore: performanceStore))
    }
}


// MARK: - Actions
public extension GameManager {
    func loadHighScore() async {
        currentHighScore = await store.loadHighScore(modeId: mode.id)
    }
    
    func saveResults(_ results: LevelResults) {
        let record = makePerformanceRecord(results: results)
        
        if let newHighScore = record.newHighScore {
            currentHighScore = newHighScore
        }
        
        store.save(record: record)
    }
}


// MARK: - Private Methods
private extension GameManager {
    func loadData() {
        Task {
            currentHighScore = await store.loadHighScore(modeId: mode.id)
            unlockedAchievements = await store.loadUnlockedAchievements(modeId: mode.id)
        }
    }
    
    func makePerformanceRecord(results: LevelResults) -> PerformanceRecord {
        let newHighScore = results.newScore > currentHighScore ? results.newScore : nil
        let unlockNextMode = shouldUnlockNextMode(levelCompleted:  results.levelCompleted, currentModeLevel: store.modeLevel)
        let newAchievements = getNewAchievements(from: results)
        
        return .init(modeId: mode.id, newHighScore: newHighScore, shouldUnlockNextMode: unlockNextMode, newAchievements: newAchievements)
    }
    
    func getNewAchievements(from results: LevelResults) -> [GameAchievement] {
        let info = results.toAchievementInfo(modeName: mode.name, completedLevelCount: store.loadTotalCompletedLevelsCount(modeId: mode.id))
        let potentialNewAchievements = AchievementManager.getAchievements(info: info)
        
        if potentialNewAchievements.isEmpty { return [] }
        
        let previouslyUnlockedIdentifiers = Set(unlockedAchievements.map { $0.identifier })
        
        // Filter out achievements that have already been unlocked
        return potentialNewAchievements.filter { !previouslyUnlockedIdentifiers.contains($0.identifier) }
    }
    
    func shouldUnlockNextMode(levelCompleted: Int?, currentModeLevel: Int) -> Bool {
        guard let levelCompleted = levelCompleted else { return false }
        
        let unlockConditions: [GameMode: (level: Int, requiredModeLevel: Int)] = [
            .add: (1, 0),
            .subtract: (10, 1),
            .hybrid: (-1, -1) // -1 or another sentinel value to indicate no unlock
        ]
        
        guard let condition = unlockConditions[mode] else { return false }
        
        return levelCompleted == condition.level && currentModeLevel == condition.requiredModeLevel
    }
}


// MARK: - Dependencies
public protocol GameStore {
    var modeLevel: Int { get }
    
    func save(record: PerformanceRecord)
    func loadHighScore(modeId: String) async -> Int
    func loadTotalCompletedLevelsCount(modeId: String) -> Int
    func loadUnlockedAchievements(modeId: String) async -> [GameAchievement]
}


// MARK: - Extension Dependencies
fileprivate extension LevelResults {
    var newScore: Int {
        return normalPoints + (bonusPoints ?? 0)
    }
    
    var levelCompleted: Int? {
        return didCompleteLevel ? level : nil
    }
    
    func toAchievementInfo(modeName: String, completedLevelCount: Int) -> ResultAchievementInfo {
        return .init(modeName: modeName, totalCompletedLevelCount: completedLevelCount, levelCompleted: levelCompleted, perfectStreakCount: perfectStreakCount, completionTime: completionTime)
    }
}
