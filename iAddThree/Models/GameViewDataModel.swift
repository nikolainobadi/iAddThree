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
    var level: Int { store.level }
    var scoreText: String { "Score: \(store.score)" }
    var highScoreText: String { "High Score: \(store.highScore)" }
    var modeTitle: String { mode.title }
    
    func loadResults(_ pointsToAdd: Int) async throws -> LevelResultInfo {
        try await store.loadResults(pointsToAdd: pointsToAdd)
    }
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
