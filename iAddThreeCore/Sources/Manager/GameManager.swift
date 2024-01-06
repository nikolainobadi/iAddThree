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
    private(set) var unlockedAchievements: [GameAchievement] = []
    
    public init(mode: GameMode, store: GameStore) {
        self.mode = mode
        self.store = store
        self.currentHighScore = store.getHighScore(modeId: mode.id)
    }
}


// MARK: - Actions
public extension GameManager {
    func saveResults(_ results: LevelResults) {
        updateHighScore(newScore: results.newScore)
        unlockNextMode(levelCompleted: results.didCompleteLevel ? results.level : nil)
    }
}


// MARK: - Private Methods
private extension GameManager {
    func unlockNextMode(levelCompleted: Int?) {
        guard
            let levelCompleted = levelCompleted,
            shouldUnlockNextMode(levelCompleted: levelCompleted, currentModeLevel: store.modeLevel)
        else { return }
        
        store.incrementModeLevel()
    }
    
    func shouldUnlockNextMode(levelCompleted: Int, currentModeLevel: Int) -> Bool {
        switch mode {
        case .add:
            return levelCompleted == 1 && currentModeLevel == 0
        case .subtract:
            return levelCompleted == 10 && currentModeLevel == 1
        case .hybrid:
            return false
        }
    }
    
    func updateHighScore(newScore: Int) {
        if newScore > currentHighScore {
            currentHighScore = newScore
            store.saveHighScore(newScore, modeId: mode.id)
        }
    }
}


// MARK: - Dependencies
public protocol GameStore {
    var modeLevel: Int { get }
    
    func incrementModeLevel()
    func getHighScore(modeId: String) -> Int
    func saveHighScore(_ score: Int, modeId: String)
}


// MARK: - Extension Dependencies
extension LevelResults {
    var newScore: Int {
        return normalPoints + (bonusPoints ?? 0)
    }
}
