//
//  UserDetaultsGameStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/3/24.
//

import Foundation
import iAddThreeCore

final class UserDefaultsGameStore {
    private let defaults: UserDefaults
    
    var highScore: Int = 0
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}


// MARK: - GameStore
extension UserDefaultsGameStore: GameStore {
    func saveHighScore(_ score: Int) {
        // save high score
    }
}
