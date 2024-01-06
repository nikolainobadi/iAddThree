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
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}


// MARK: - GameStore
extension UserDefaultsGameStore: GameStore {
    func getHighScore(modeId: String) -> Int {
        return defaults.integer(forKey: modeId)
    }
    
    func saveHighScore(_ score: Int, modeId: String) {
        defaults.setValue(score, forKey: modeId)
    }
}
