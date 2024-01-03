//
//  UserDetaultsGameStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/3/24.
//

import Foundation
import iAddThreeCore

final class UserDetaultsGameStore {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
}


// MARK: - Store
extension UserDetaultsGameStore: GameStore {
    func saveHighScore(_ score: Int) {
        
    }
}
