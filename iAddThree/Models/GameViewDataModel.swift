//
//  GameViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class GameViewDataModel: ObservableObject {
    private let mode: GameMode
    private let store: GameStore
    
    init(mode: GameMode, store: GameStore = GameStorageManager()) {
        self.mode = mode
        self.store = store
    }
}


// MARK: - View Model
extension GameViewDataModel {
    var modeTitle: String { mode.title }
    
    func loadResults(_ pointsToAdd: Int) async throws -> LevelResultInfo { try await store.loadResults(pointsToAdd: pointsToAdd) }
}


// MARK: - Dependencies
protocol GameStore {
    var score: Int { get }
    var level: Int { get }
    var highScore: Int { get }
    
    func loadResults(pointsToAdd: Int) async throws -> LevelResultInfo
}

extension GameMode {
    var title: String {
        switch self {
        case .add: return "Add Three"
        }
    }
}


// MARK: - GameStorageManager
final class GameStorageManager {
    private let store: HighScoreStore
    
    var score = 0
    var level = 1
    
    init(store: HighScoreStore = SinglePlayHighScoreStore()) {
        self.store = store
    }
}


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
}


private extension GameStorageManager {
    func makeNewLevel() -> Int { level + 1 }
    func makeNewScore(_ pointsToAdd: Int) -> Int { score + pointsToAdd }
}


protocol HighScoreStore {
    var highScore: Int { get }
    func saveHighScore(_ newHighScore: Int) async throws
}


// MARK: - HighScoreStore
final class SinglePlayHighScoreStore: HighScoreStore {
    var highScore: Int = 0
    
    func saveHighScore(_ newHighScore: Int) async throws { highScore = newHighScore }
}
