//
//  ClassicResultStoreAdapter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation
import iAddThreeCore
import iAddThreeClassicKit

final class ClassicResultStoreAdapter {
    private let manager: GameManager
    
    init(manager: GameManager) {
        self.manager = manager
    }
}


// MARK: - Store
extension ClassicResultStoreAdapter: iAddThreeClassicKit.ClassicResultStore {
    var highScore: Int {
        return manager.currentHighScore
    }
    
    func saveResults(_ results: iAddThreeClassicKit.ClassicLevelResults) {
        manager.saveResults(results.toLevelResults())
    }
}


// MARK: - Extension Dependencies
extension ClassicLevelResults {
    var pointsAndBonus: Int {
        return correctAnswerCount + (bonusPoints ?? 0)
    }
    
    func toLevelResults() -> LevelResults {
        return .init(score: pointsAndBonus, level: currentLevel, didCompleteLevel: completionTime != nil, completionTime: completionTime)
    }
}
