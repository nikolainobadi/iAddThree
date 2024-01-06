//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

public final class GameManager {
    private let modeId: String
    private let store: GameStore
    
    public private(set) var currentHighScore: Int
    private(set) var unlockedAchievements: [GameAchievement] = []
    
    public init(modeId: String, store: GameStore) {
        self.store = store
        self.modeId = modeId
        self.currentHighScore = store.getHighScore(modeId: modeId)
    }
}


// MARK: - Actions
public extension GameManager {
    func saveResults(_ results: LevelResults) {
        updateHighScore(newScore: results.newScore)
    }
}


// MARK: - Private Methods
private extension GameManager {
    func updateHighScore(newScore: Int) {
        if newScore > currentHighScore {
            currentHighScore = newScore
            store.saveHighScore(newScore, modeId: modeId)
        }
    }
}


// MARK: - Dependencies
public protocol GameStore {
    func getHighScore(modeId: String) -> Int
    func saveHighScore(_ score: Int, modeId: String)
}


// MARK: - Extension Dependencies
extension LevelResults {
    var newScore: Int {
        return normalPoints + (bonusPoints ?? 0)
    }
}
