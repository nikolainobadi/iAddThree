//
//  InheritableUserDefaultsGameModeStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import Foundation
import iAddThreeCore

class InheritableUserDefaultsGameModeStore {
    let defaults: UserDefaults
    
    init(defaults: UserDefaults = .customInit()) {
        self.defaults = defaults
    }
}


// MARK: - GameModeStore
extension InheritableUserDefaultsGameModeStore: GameModeStore {
    var modeLevel: Int {
        return defaults.integer(forKey: AppStorageKey.modeLevel)
    }
}
