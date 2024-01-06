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
    var modeLevel: Int {
        return defaults.integer(forKey: AppStorageKey.modeLevel)
    }
    
    func incrementModeLevel() {
        defaults.setValue(modeLevel + 1, forKey: AppStorageKey.modeLevel)
    }
    
    func getHighScore(modeId: String) -> Int {
        return defaults.integer(forKey: modeId)
    }
    
    func saveHighScore(_ score: Int, modeId: String) {
        defaults.setValue(score, forKey: modeId)
    }
}
