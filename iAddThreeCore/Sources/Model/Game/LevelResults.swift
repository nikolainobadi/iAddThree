//
//  LevelResults.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

/// `LevelResults` represents the outcome of a game level.
public struct LevelResults {
    /// The current level number.
    let level: Int

    /// The score before adding any points from this level.
    let scoreBeforePoints: Int

    /// Points earned normally in this level.
    let normalPoints: Int

    /// Optional bonus points earned in this level.
    let bonusPoints: Int?

    /// Flag indicating whether the level was completed successfully.
    let didCompleteLevel: Bool

    /// Count of consecutive perfect streaks achieved in this level.
    let perfectStreakCount: Int

    /// Optional time taken to complete the level.
    let completionTime: TimeInterval?
    
    /// Computed property to get the new score after adding normal and bonus points to the initial score.
    var newScore: Int {
        return scoreBeforePoints + normalPoints + (bonusPoints ?? 0)
    }
    
    /// Initializes a new `LevelResults` instance with provided values.
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
