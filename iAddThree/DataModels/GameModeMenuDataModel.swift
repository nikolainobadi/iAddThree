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
    
    private let resetHandler: ScoreResetHandler
    
    init(resetHandler: ScoreResetHandler, highScore: Int) {
        self.resetHandler = resetHandler
        self.highScore = highScore
    }
}


// MARK: - ViewModel
extension GameModeMenuDataModel {
    func resetHighScore() {
        Task {
            do {
                try await resetHandler.resetHighScore()
                
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
protocol ScoreResetHandler {
    func resetHighScore() async throws
}

