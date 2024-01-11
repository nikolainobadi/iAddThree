//
//  PerformanceRecord.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

/// `PerformanceRecord` captures the key performance metrics of a game level.
public struct PerformanceRecord {
    /// The game mode in which the performance was recorded.
    public let mode: GameMode

    /// The new high score achieved in the game mode, if any.
    public let newHighScore: Int?

    /// A boolean indicating whether the performance qualifies for unlocking the next mode.
    public let shouldUnlockNextMode: Bool

    /// A list of new achievements unlocked in this performance.
    public let newAchievements: [GameAchievement]

    /// Initializes a new instance of `PerformanceRecord`.
    /// - Parameters:
    ///   - mode: The game mode of the performance.
    ///   - newHighScore: The new high score achieved, if any.
    ///   - shouldUnlockNextMode: A boolean indicating if the next mode should be unlocked.
    ///   - newAchievements: A list of achievements unlocked in this performance.
    public init(mode: GameMode, newHighScore: Int?, shouldUnlockNextMode: Bool, newAchievements: [GameAchievement]) {
        self.mode = mode
        self.newHighScore = newHighScore
        self.shouldUnlockNextMode = shouldUnlockNextMode
        self.newAchievements = newAchievements
    }
}

