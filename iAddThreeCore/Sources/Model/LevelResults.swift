//
//  LevelResults.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

public struct LevelResults {
    let score: Int
    let level: Int
    let didCompleteLevel: Bool
    let completionTime: TimeInterval?
    
    public init(score: Int, level: Int, didCompleteLevel: Bool, completionTime: TimeInterval?) {
        self.score = score
        self.level = level
        self.didCompleteLevel = didCompleteLevel
        self.completionTime = completionTime
    }
}
