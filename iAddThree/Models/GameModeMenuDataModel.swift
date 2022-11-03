//
//  GameModeMenuDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import Foundation

final class GameModeMenuDataModel: ObservableObject {
    @Published var error: Error?
    @Published var didResetHighScore = false
    
    private let store: HighScoreStore
    
    init(store: HighScoreStore) {
        self.store = store
    }
}


// MARK: - ViewModel
extension GameModeMenuDataModel {
    var highScore: Int { store.highScore }
    
    func resetHighScore() {
        Task {
            do {
                try await store.saveHighScore(0)
                
                await hideHighScoreView()
            } catch {
                await showError(error)
            }
        }
    }
}


// MARK: - Private
private extension GameModeMenuDataModel {
    @MainActor func hideHighScoreView() { didResetHighScore = true }
    @MainActor func showError(_ error: Error) { self.error = error }
}
