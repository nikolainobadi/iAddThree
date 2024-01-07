//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

public final class GameManager {
    private let mode: GameMode
    private let store: GameStore
    
    public private(set) var currentHighScore: Int
    private var unlockedAchievements: [GameAchievement]
    
    public init(mode: GameMode, store: GameStore) {
        self.mode = mode
        self.store = store
        self.currentHighScore = store.getHighScore(modeId: mode.id)
        self.unlockedAchievements = store.loadUnlockedAchievements(modeId: mode.id)
    }
}


// MARK: - Actions
public extension GameManager {
    func saveResults(_ results: LevelResults) {
        store.saveRecord(record: makePerformanceRecord(results: results))
    }
}


// MARK: - Private Methods
private extension GameManager {
    func makePerformanceRecord(results: LevelResults) -> PerformanceRecord {
        let newHighScore = results.newScore > currentHighScore ? results.newScore : nil
        let unlockNextMode = shouldUnlockNextMode(levelCompleted:  results.levelCompleted, currentModeLevel: store.modeLevel)
        let info = results.toAchievementInfo(modeName: mode.name, completedLevelCount: store.getCompletedLevelsCount(modeId: mode.id))
        let newAchievements = AchievementManager.getAchievements(info: info, previouslyUnlocked: unlockedAchievements)
        
        return .init(modeId: mode.id, newHighScore: newHighScore, shouldUnlockNextMode: unlockNextMode, newAchievements: newAchievements)
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
    
    func getHighScore(modeId: String) -> Int
    func getCompletedLevelsCount(modeId: String) -> Int
    func saveRecord(record: PerformanceRecord)
    func loadUnlockedAchievements(modeId: String) -> [GameAchievement]
}


// MARK: - Extension Dependencies
extension LevelResults {
    var newScore: Int {
        return normalPoints + (bonusPoints ?? 0)
    }
    
    var levelCompleted: Int? {
        return didCompleteLevel ? level : nil
    }
    
    func toAchievementInfo(modeName: String, completedLevelCount: Int) -> ResultAchievementInfo {
        return .init(modeName: modeName, completedLevelCount: completedLevelCount, levelCompleted: levelCompleted, perfectStreakCount: perfectStreakCount, completionTime: completionTime)
    }
}


