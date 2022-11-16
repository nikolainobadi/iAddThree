//
//  ModeLevelHighScoreStoreDecorator.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/15/22.
//

import Foundation

final class ModeLevelHighScoreStoreDecorator {
    private let mode: GameMode
    private let defaults: UserDefaults
    private let decoratee: HighScoreStore
    
    init(mode: GameMode, decoratee: HighScoreStore, defaults: UserDefaults = UserDefaults.standard) {
        self.mode = mode
        self.defaults = defaults
        self.decoratee = decoratee
    }
}


// MARK: - Store
extension ModeLevelHighScoreStoreDecorator: HighScoreStore {
    var highScore: Int { decoratee.highScore }
    
    func saveHighScore(_ newHighScore: Int) async throws {
        updateModeLevel(newHighScore)
        try await decoratee.saveHighScore(newHighScore)
    }
}


// MARK: - Private Methods
private extension ModeLevelHighScoreStoreDecorator {
    var modeLevel: Int { defaults.value(forKey: AppStorageKey.modeLevel) as? Int ?? 1 }
    var canUpdateModeLevel: Bool {
        switch mode {
        case .add: return modeLevel == 1
        case .subtract: return false
        }
    }
    
    var upgradeNumber: Int {
        switch mode {
        case .add: return 1
        case .subtract: return 10
        }
    }
    
    func updateModeLevel(_ newHighScore: Int) {
        guard canUpdateModeLevel else { return }
        
        if newHighScore >= upgradeNumber {
            
        }
    }
}
