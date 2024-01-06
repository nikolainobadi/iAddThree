//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

public final class GameManager {
    private let store: GameStore
    
    public private(set) var currentHighScore: Int
    private(set) var unlockedAchievements: [GameAchievement] = []
    
    public init(store: GameStore) {
        self.store = store
        self.currentHighScore = store.highScore
    }
}


// MARK: - Actions
public extension GameManager {
    func saveResults(_ results: LevelResults) {
        updateHighScore(newScore: results.normalPoints)
    }
}


// MARK: - Private Methods
private extension GameManager {
    func updateHighScore(newScore: Int) {
        if newScore > currentHighScore {
            store.saveHighScore(newScore)
        }
    }
}


// MARK: - Dependencies
public protocol GameStore {
    var highScore: Int { get }
    
    func saveHighScore(_ score: Int)
}
