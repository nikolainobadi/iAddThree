//
//  ClassicResultsAdapter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation
import iAddThreeCore
import iAddThreeClassicKit

final class ClassicResultsAdapter: ObservableObject {
    @Published var currentHighScore = 0
    
    private let manager: GameManager
    
    init(manager: GameManager) {
        self.manager = manager
        
        manager.$currentHighScore
            .receive(on: RunLoop.main)
            .assign(to: &$currentHighScore)
    }
}


// MARK: - ViewModel
extension ClassicResultsAdapter {
    var mode: ClassicGameMode {
        return manager.mode.classicMode
    }
    
    func loadHighScore() async {
        await manager.loadHighScore()
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
