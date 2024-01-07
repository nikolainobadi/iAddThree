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
    func toLevelResults() -> LevelResults {
        return .init(
            level: currentLevel,
            normalPoints: correctAnswerCount,
            bonusPoints: bonusPoints,
            didCompleteLevel: completionTime != nil, 
            perfectStreakCount: perfectStreakCount,
            completionTime: completionTime
        )
    }
}
