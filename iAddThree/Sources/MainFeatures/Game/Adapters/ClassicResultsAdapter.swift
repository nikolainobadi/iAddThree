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
        await manager.loadData()
    }
    
    func saveResults(_ results: iAddThreeClassicKit.ClassicLevelResults) {
        manager.saveResults(results.toLevelResults())
    }
}


// MARK: - Extension Dependencies
extension ClassicLevelResults {
    var didCompleteLevel: Bool {
        let allAnswersFilled = numberList.allSatisfy({ $0.userAnswer != nil })
        let scoredAtLeaseOnePoint = numberList.filter({ $0.isCorrect }).count > 0
        
        return allAnswersFilled && scoredAtLeaseOnePoint
    }
    
    func toLevelResults() -> LevelResults {
        return .init(
            level: currentLevel,
            scoreBeforePoints: currentScore,
            normalPoints: correctAnswerCount,
            bonusPoints: bonusPoints,
            didCompleteLevel: didCompleteLevel,
            perfectStreakCount: perfectStreakCount,
            completionTime: completionTime
        )
    }
}
