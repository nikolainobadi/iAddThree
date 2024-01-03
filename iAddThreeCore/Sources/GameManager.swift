//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

final class GameManager {
    private let store: GameStore
    
    init(store: GameStore) {
        self.store = store
    }
}


// MARK: - Dependencies
protocol GameStore {
    
}
