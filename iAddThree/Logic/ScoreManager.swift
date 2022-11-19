//
//  ScoreManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import Foundation

final class ScoreManager {
    private let highScoreStore: HighScoreStore
    private let levelScoreStore: LevelScoreStore
    
    init(highScoreStore: HighScoreStore, levelScoreStore: LevelScoreStore) {
        self.highScoreStore = highScoreStore
        self.levelScoreStore = levelScoreStore
    }
}


// MARK: - Updater
extension ScoreManager: ScoreUpdater {
    func updateScore(newScore: Int) async throws {
        if newScore > highScore {
            try await highScoreStore.saveHighScore(newScore)
        }
        
        updateScoreAndLevel(score: newScore, level: level + 1)
    }
}


// MARK: - ResetHandler
extension ScoreManager: ScoreResetHandler {
    func resetHighScore() async throws {
        try await highScoreStore.saveHighScore(0)
        
        updateScoreAndLevel(score: 0, level: 1)
    }
}


// MARK: - Private 
private extension ScoreManager {
    var level: Int { levelScoreStore.level }
    var highScore: Int { highScoreStore.highScore }
    
    func updateScoreAndLevel(score: Int, level: Int) {
        levelScoreStore.updateScore(score)
        levelScoreStore.updateLevel(level)
    }
}


// MARK: - Dependencies
protocol HighScoreStore {
    var highScore: Int { get }
    
    func saveHighScore(_ newHighScore: Int) async throws
}

protocol LevelScoreStore {
    var score: Int { get }
    var level: Int { get }
    
    func updateLevel(_ newLevel: Int)
    func updateScore(_ newScore: Int)
}
