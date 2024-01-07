//
//  PerformanceRecord.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

public struct PerformanceRecord {
    public let modeId: String
    public let newHighScore: Int?
    public let shouldUnlockNextMode: Bool
    public let newAchievements: [GameAchievement]
    
    public init(modeId: String, newHighScore: Int?, shouldUnlockNextMode: Bool, newAchievements: [GameAchievement]) {
        self.modeId = modeId
        self.newHighScore = newHighScore
        self.shouldUnlockNextMode = shouldUnlockNextMode
        self.newAchievements = newAchievements
    }
}
