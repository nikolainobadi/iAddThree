//
//  UserDefaultsGamePerformanceStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/3/24.
//

import Foundation
import iAddThreeCore

final class UserDefaultsGamePerformanceStore: InheritableUserDefaultsGameModeStore, GamePerformanceStore { 
    func getHighScore(modeId: String) -> Int {
        return defaults.integer(forKey: modeId)
    }
    
    func getTotalCompletedLevelsCount(modeId: String) -> Int {
        return defaults.integer(forKey: AppStorageKey.totalCompletedLevelsKey(modeId: modeId))
    }
    
    func incrementModeLevel() {
        defaults.setValue(modeLevel + 1, forKey: AppStorageKey.modeLevel)
    }
    
    func incrementTotalCompletedLevels(modeId: String) {
        let count = getTotalCompletedLevelsCount(modeId: modeId)
        
        defaults.setValue(count + 1, forKey: AppStorageKey.totalCompletedLevelsKey(modeId: modeId))
    }
    
    func saveHighScore(_ score: Int, modeId: String) {
        defaults.setValue(score, forKey: modeId)
    }
}
