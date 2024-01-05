//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

public final class GameManager {
    private let store: GameStore
    
    public private(set) var currentHighScore: Int
    private(set) var unlockedAchievements: [GameAchievement]
    
    public init(store: GameStore, currentHighScore: Int = 0, unlockedAchievements: [GameAchievement] = []) {
        self.store = store
        self.currentHighScore = currentHighScore
        self.unlockedAchievements = unlockedAchievements
    }
}


// MARK: - Actions
public extension GameManager {
    func saveResults(_ results: LevelResults) {
        updateHighScore(newScore: results.score)
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
