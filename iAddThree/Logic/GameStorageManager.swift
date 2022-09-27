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
    var level = 2 // gameStore variable
    
    init(store: HighScoreStore = SinglePlayHighScoreStore()) {
        self.store = store
    }
}
 

// MARK: - Store
extension GameStorageManager: GameStore {
    var highScore: Int { store.highScore }
    
    func loadResults(pointsToAdd: Int) async throws -> LevelResultInfo {
        guard pointsToAdd > 0 else { return LevelResultInfo(currentScore: score, newScore: nil, previousLevel: level) }
        
        let newScore = makeNewScore(pointsToAdd)
        let results = LevelResultInfo(currentScore: score, newScore: newScore, previousLevel: level)
        
        if newScore > highScore {
            try await store.saveHighScore(newScore)
        }
        
        level = makeNewLevel()
        score = newScore
        
        return results
    }
    
    func resetHighScore() async throws {
        try await store.resetHighScore()
    }
}


// MARK: - Private Methods
private extension GameStorageManager {
    func makeNewLevel() -> Int { level + 1 }
    func makeNewScore(_ pointsToAdd: Int) -> Int { score + pointsToAdd }
}


// MARK: - Dependencies
protocol HighScoreStore {
    var highScore: Int { get }
    
    func saveHighScore(_ newHighScore: Int) async throws
    func resetHighScore() async throws
}
