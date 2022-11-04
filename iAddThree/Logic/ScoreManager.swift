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
        if newScore == 0 {
            try await resetScoreInfo()
        } else {
            try await saveNewScore(newScore)
        }
    }
}


// MARK: - Private 
private extension ScoreManager {
    var level: Int { levelScoreStore.level }
    var highScore: Int { highScoreStore.highScore }
    
    func resetScoreInfo() async throws {
        try await highScoreStore.saveHighScore(0)
        updateScoreAndLevel(score: 0, level: 1)
    }
    
    func saveNewScore(_ newScore: Int) async throws {
        try await highScoreStore.saveHighScore(newScore)
        updateScoreAndLevel(score: newScore, level: level + 1)
    }
    
    func updateScoreAndLevel(score: Int, level: Int) {
        levelScoreStore.updateScore(score)
        levelScoreStore.updateLevel(level)
    }
}
