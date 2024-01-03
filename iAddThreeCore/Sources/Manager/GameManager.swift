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
    
    init(store: GameStore) {
        self.store = store
    }
}


// MARK: - Actions
extension GameManager {
    func saveResults(_ results: LevelResults) {
        
    }
}


// MARK: - Dependencies
protocol GameStore {
    
}
