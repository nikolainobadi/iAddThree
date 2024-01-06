//
//  UserDefaultsGameModeStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation
import iAddThreeCore

final class UserDefaultsGameModeStore {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}


// MARK: - Store
extension UserDefaultsGameModeStore: GameModeStore {
    var modeLevel: Int {
        return defaults.integer(forKey: AppStorageKey.modeLevel)
    }
}
