//
//  UserDefaultsHighScoreStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/26/22.
//

import Foundation

final class UserDefaultsHighScoreStore {
    private let mode: GameMode
    private let defaults: UserDefaults
    
    init(mode: GameMode, defaults: UserDefaults = .standard) {
        self.mode = mode
        self.defaults = defaults
    }
}


// MARK: - Store
extension UserDefaultsHighScoreStore: HighScoreStore {
    var highScore: Int { defaults.integer(forKey: mode.title) }
    
    func saveHighScore(_ newHighScore: Int) async throws { defaults.set(newHighScore, forKey: mode.title) }
    func resetHighScore() async throws { defaults.set(0, forKey: mode.title) }
}


extension GameMode {
    var title: String {
        switch self {
        case .add: return "Add Three"
        case .subtract: return "Subtract Three"
        }
    }
}
