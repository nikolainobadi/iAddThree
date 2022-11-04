//
//  GameStorageManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class GameStorageManager {
    private let store: HighScoreStore
    
    var score = 0 // gameStore variable
    var level = 1 // gameStore variable
    
    init(store: HighScoreStore) {
        self.store = store
    }
}
 

// MARK: - Store
extension GameStorageManager: GameStore {
    var highScore: Int { 0 }
    
    func loadResults(pointsToAdd: Int, timerFinished: Bool) async throws -> LevelResults {
        let newScore = makeNewScore(pointsToAdd)
        let results = LevelResults(currentScore: score, pointsToAdd: pointsToAdd, currentLevel: level, timerFinished: timerFinished)
    
        guard pointsToAdd > 0 else { return results }
        
        if newScore > highScore {
            try await store.saveHighScore(newScore)
        }
        
        level = makeNewLevel()
        score = newScore
        
        return results
    }
}


// MARK: - Private Methods
private extension GameStorageManager {
    func makeNewLevel() -> Int { level + 1 }
    func makeNewScore(_ pointsToAdd: Int) -> Int { score + pointsToAdd }
}


// MARK: - Dependencies
protocol HighScoreStore {
    func saveHighScore(_ newHighScore: Int) async throws
}
