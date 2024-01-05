//
//  UserDetaultsGameStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/3/24.
//

import Foundation
import iAddThreeCore

final class UserDefaultsGameStore {
    private let modeId: String
    private let defaults: UserDefaults
    
    var highScore: Int = 0
    
    init(modeId: String, defaults: UserDefaults = .standard) {
        self.modeId = modeId
        self.defaults = defaults
        
        highScore = defaults.integer(forKey: modeId)
    }
}


// MARK: - GameStore
extension UserDefaultsGameStore: GameStore {
    func saveHighScore(_ score: Int) {
        defaults.setValue(score, forKey: modeId)
    }
}
