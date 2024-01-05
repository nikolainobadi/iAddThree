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
    var highScore: Int { 0 }
    
    func saveResults(_ results: iAddThreeClassicKit.ClassicLevelResults) {
        
    }
}


// MARK: - Extension Dependencies
extension ClassicLevelResults {
    var totalScore: Int {
        return correctAnswerCount + (bonusPoints ?? 0)
    }
}
