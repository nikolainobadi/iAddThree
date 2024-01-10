//
//  LevelResults.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

public struct LevelResults {
    let level: Int
    let scoreBeforePoints: Int
    let normalPoints: Int
    let bonusPoints: Int?
    let didCompleteLevel: Bool
    let perfectStreakCount: Int
    let completionTime: TimeInterval?
    
    var newScore: Int {
        return scoreBeforePoints + normalPoints + (bonusPoints ?? 0)
    }
    
    public init(level: Int, scoreBeforePoints: Int, normalPoints: Int, bonusPoints: Int?, didCompleteLevel: Bool, perfectStreakCount: Int, completionTime: TimeInterval?) {
        self.level = level
        self.scoreBeforePoints = scoreBeforePoints
        self.normalPoints = normalPoints
        self.bonusPoints = bonusPoints
        self.didCompleteLevel = didCompleteLevel
        self.perfectStreakCount = perfectStreakCount
        self.completionTime = completionTime
    }
}
