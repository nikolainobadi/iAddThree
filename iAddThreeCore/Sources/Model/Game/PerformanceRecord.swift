//
//  PerformanceRecord.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

public struct PerformanceRecord {
    public let mode: GameMode
    public let newHighScore: Int?
    public let shouldUnlockNextMode: Bool
    public let newAchievements: [GameAchievement]
    
    public init(mode: GameMode, newHighScore: Int?, shouldUnlockNextMode: Bool, newAchievements: [GameAchievement]) {
        self.mode = mode
        self.newHighScore = newHighScore
        self.shouldUnlockNextMode = shouldUnlockNextMode
        self.newAchievements = newAchievements
    }
}
