//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

final class GameManager {
    private let store: GameStore
    
    private(set) var currentHighScore = 0
    private(set) var unlockedAchievements: [GameAchievement] = []
    
    init(store: GameStore) {
        self.store = store
    }
}


// MARK: - Actions
extension GameManager {
    func saveResults(_ results: LevelResults) {
        updateHighScore(newScore: results.score)
    }
}


// MARK: - Private Methods
private extension GameManager {
    func updateHighScore(newScore: Int) {
        if newScore > currentHighScore {
            
        }
    }
}


// MARK: - Dependencies
protocol GameStore {
    func saveHighScore(_ score: Int)
}
