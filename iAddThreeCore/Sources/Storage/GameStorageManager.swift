//
//  GameStorageManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import Foundation

/// `GameStorageManager` acts as a central manager for game-related data storage, interfacing with both social and performance data stores.
final class GameStorageManager {
    /// Store for managing social performance aspects like achievements and leaderboards.
    private let socialStore: SocialPerformanceStore

    /// Store for managing game performance data like high scores and levels.
    private let performanceStore: GamePerformanceStore
    
    /// Initializes a new instance of `GameStorageManager`.
    /// - Parameters:
    ///   - socialStore: An instance of `SocialPerformanceStore`.
    ///   - performanceStore: An instance of `GamePerformanceStore`.
    init(socialStore: SocialPerformanceStore, performanceStore: GamePerformanceStore) {
        self.socialStore = socialStore
        self.performanceStore = performanceStore
    }
}

// MARK: - Store
extension GameStorageManager: GameStore {
    /// Current mode level from the performance store.
    var modeLevel: Int {
        return performanceStore.modeLevel
    }
    
    /// Loads unlocked achievements for a given game mode.
    /// - Parameter mode: The game mode for which to load achievements.
    /// - Returns: An array of `GameAchievement` unlocked in the mode.
    func loadUnlockedAchievements(mode: GameMode) async -> [GameAchievement] {
        return await socialStore.loadUnlockedAchievements()
    }
    
    /// Loads the total count of completed levels for a given game mode.
    /// - Parameter mode: The game mode for which to load the level count.
    /// - Returns: The total number of completed levels as an integer.
    func loadTotalCompletedLevelsCount(mode: GameMode) -> Int {
        return performanceStore.getTotalCompletedLevelsCount(modeId: mode.storageId)
    }
    
    /// Loads the high score for a given game mode, updating local storage with social store data if necessary.
    /// - Parameter mode: The game mode for which to load the high score.
    /// - Returns: The high score as an integer.
    func loadHighScore(mode: GameMode) async -> Int {
        guard let leaderboardHighScore = await socialStore.loadHighScore(modeId: mode.storageId) else {
            return performanceStore.getHighScore(modeId: mode.storageId)
        }
        
        if leaderboardHighScore > performanceStore.getHighScore(modeId: mode.storageId) {
            performanceStore.saveHighScore(leaderboardHighScore, modeId: mode.storageId)
        }
        
        return leaderboardHighScore
    }
    
    /// Saves a performance record, updating achievements and high scores.
    /// - Parameter record: The `PerformanceRecord` to save.
    func save(record: PerformanceRecord) {
        socialStore.saveAchievements(record.newAchievements)
        unlockModes(shouldUnlockNextMode: record.shouldUnlockNextMode)
        saveHighScore(newHighScore: record.newHighScore, modeId: record.mode.storageId)
    }
}

// MARK: - Private Methods
private extension GameStorageManager {
    /// Saves a new high score to both social and performance stores.
    /// - Parameters:
    ///   - newHighScore: The new high score to save.
    ///   - modeId: The identifier of the game mode.
    func saveHighScore(newHighScore: Int?, modeId: String) {
        if let newHighScore = newHighScore {
            socialStore.saveHighScore(newHighScore, modeId: modeId)
            performanceStore.saveHighScore(newHighScore, modeId: modeId)
        }
    }
    
    /// Unlocks the next mode level in the performance store if conditions are met.
    /// - Parameter shouldUnlockNextMode: A boolean indicating whether the next mode should be unlocked.
    func unlockModes(shouldUnlockNextMode: Bool) {
        if shouldUnlockNextMode {
            performanceStore.incrementModeLevel()
        }
    }
}

// MARK: - Dependencies
/// Protocol defining the necessary properties and methods for a game performance data store.
public protocol GamePerformanceStore {
    /// The current level of the game mode.
    var modeLevel: Int { get }
    
    /// Retrieves the high score for a specific game mode.
    /// - Parameter modeId: The identifier of the game mode.
    /// - Returns: The high score as an integer.
    func getHighScore(modeId: String) -> Int

    /// Retrieves the total count of completed levels for a specific game mode.
    /// - Parameter modeId: The identifier of the game mode.
    /// - Returns: The total number of completed levels as an integer.
    func getTotalCompletedLevelsCount(modeId: String) -> Int

    /// Increments the mode level, unlocking the next mode.
    func incrementModeLevel()

    /// Saves a new high score for a specific game mode.
    /// - Parameters:
    ///   - newHighScore: The new high score to save.
    ///   - modeId: The identifier of the game mode.
    func saveHighScore(_ newHighScore: Int, modeId: String)
}

/// Protocol defining the necessary properties and methods for a social performance data store.
public protocol SocialPerformanceStore {
    /// Loads the high score for a specific game mode from a social perspective.
    /// - Parameter modeId: The identifier of the game mode.
    /// - Returns: The high score as an optional integer.
    func loadHighScore(modeId: String) async -> Int?

    /// Loads unlocked achievements from a social perspective.
    /// - Returns: An array of `GameAchievement`.
    func loadUnlockedAchievements() async -> [GameAchievement]

    /// Saves a new high score from a social perspective.
    /// - Parameters:
    ///   - newHighScore: The new high score to save.
    ///   - modeId: The identifier of the game mode.
    func saveHighScore(_ newHighScore: Int, modeId: String)

    /// Saves new achievements to the social store.
    /// - Parameter achievements: An array of `GameAchievement` to save.
    func saveAchievements(_ achievements: [GameAchievement])
}

// MARK: - Extension Dependencies
/// Extension for `GameMode` providing a storage identifier.
extension GameMode {
    /// Provides a unique storage identifier for each game mode.
    var storageId: String {
        switch self {
        case .add:
            return "ADD_THREE_CLASSIC"
        case .subtract:
            return "SUBTRACT_THREE_CLASSIC"
        case .hybrid:
            return "HYBRID_CLASSIC"
        }
    }
}
