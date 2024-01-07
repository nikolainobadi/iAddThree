//
//  LevelResults.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

public struct LevelResults {
    let level: Int
    let normalPoints: Int
    let bonusPoints: Int?
    let didCompleteLevel: Bool
    let completionTime: TimeInterval?
    
    public init(level: Int, normalPoints: Int, bonusPoints: Int?, didCompleteLevel: Bool, completionTime: TimeInterval?) {
        self.level = level
        self.normalPoints = normalPoints
        self.bonusPoints = bonusPoints
        self.didCompleteLevel = didCompleteLevel
        self.completionTime = completionTime
    }
}
