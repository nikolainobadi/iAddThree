//
//  GameModeMenuDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import Foundation

final class GameModeMenuDataModel: ObservableObject {
    @Published var error: Error?
    @Published var highScore: Int
    
    private let updater: ScoreUpdater
    
    init(updater: ScoreUpdater, highScore: Int) {
        self.updater = updater
        self.highScore = highScore
    }
}


// MARK: - ViewModel
extension GameModeMenuDataModel {
    func resetHighScore() {
        Task {
            do {
                try await updater.updateScore(newScore: 0)
                
                await hideHighScoreView()
            } catch {
                await showError(error)
            }
        }
    }
}


// MARK: - Private
private extension GameModeMenuDataModel {
    @MainActor func hideHighScoreView() { highScore = 0 }
    @MainActor func showError(_ error: Error) { self.error = error }
}


// MARK: - Dependencies
protocol ScoreUpdater {
    func updateScore(newScore: Int) async throws
}

final class ScoreManager: ScoreUpdater {
    func updateScore(newScore: Int) async throws {
        
    }
}
