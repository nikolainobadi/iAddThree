//
//  GameManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import Foundation

/// `GameManager` is responsible for managing the gameplay, including tracking scores, achievements, and game data.
public final class GameManager {
    /// The current high score for the game mode.
    @Published public var currentHighScore: Int = 0

    /// The active game mode.
    public let mode: GameMode

    /// Store for managing game-related data and achievements.
    private let store: GameStore

    /// A list of achievements that have been unlocked in the current game mode.
    private var unlockedAchievements: [GameAchievement] = []
    
    /// Initializes a new instance of `GameManager`.
    /// - Parameters:
    ///   - mode: The active game mode.
    ///   - store: A `GameStore` instance for data management.
    init(mode: GameMode, store: GameStore) {
        self.mode = mode
        self.store = store
    }
}

// MARK: - Convenience init
public extension GameManager {
    /// Convenience initializer for creating a `GameManager` with specific stores.
    /// - Parameters:
    ///   - mode: The active game mode.
    ///   - socialStore: `SocialPerformanceStore` instance.
    ///   - performanceStore: `GamePerformanceStore` instance.
    convenience init(mode: GameMode, socialStore: SocialPerformanceStore, performanceStore: GamePerformanceStore) {
        self.init(mode: mode, store: GameStorageManager(socialStore: socialStore, performanceStore: performanceStore))
    }
}

// MARK: - Actions
public extension GameManager {
    /// Loads game data including the high score and unlocked achievements.
    func loadData() async {
        currentHighScore = await store.loadHighScore(mode: mode)
        unlockedAchievements = await store.loadUnlockedAchievements(mode: mode)
    }
    
    /// Saves the results of a completed game level.
    /// - Parameter results: `LevelResults` from the completed level.
    func saveResults(_ results: LevelResults) {
        let record = makePerformanceRecord(results: results)
        
        if let newHighScore = record.newHighScore {
            currentHighScore = newHighScore
        }
        
        store.save(record: record)
    }
}

// MARK: - Private Methods
private extension GameManager {
    /// Creates a `PerformanceRecord` based on the results of a completed level.
    /// - Parameter results: `LevelResults` from the completed level.
    /// - Returns: A `PerformanceRecord` object.
    func makePerformanceRecord(results: LevelResults) -> PerformanceRecord {
        let newHighScore = results.newScore > currentHighScore ? results.newScore : nil
        let unlockNextMode = shouldUnlockNextMode(levelCompleted:  results.levelCompleted, currentModeLevel: store.modeLevel)
        let newAchievements = getNewAchievements(from: results)
        
        return .init(mode: mode, newHighScore: newHighScore, shouldUnlockNextMode: unlockNextMode, newAchievements: newAchievements)
    }
    
    /// Filters and returns new achievements based on the game level results.
    /// - Parameter results: `LevelResults` from the completed level.
    /// - Returns: An array of newly unlocked `GameAchievement`.
    func getNewAchievements(from results: LevelResults) -> [GameAchievement] {
        let info = results.toAchievementInfo(modeName: mode.name, completedLevelCount: store.loadTotalCompletedLevelsCount(mode: mode))
        let potentialNewAchievements = AchievementManager.getAchievements(info: info)
        
        if potentialNewAchievements.isEmpty { return [] }
        
        let previouslyUnlockedIdentifiers = Set(unlockedAchievements.map { $0.identifier })
        
        // Filter out achievements that have already been unlocked
        return potentialNewAchievements.filter { !previouslyUnlockedIdentifiers.contains($0.identifier) }
    }
    
    /// Determines whether the next game mode should be unlocked based on the level completed.
    /// - Parameters:
    ///   - levelCompleted: The level number that was completed.
    ///   - currentModeLevel: The current level of the game mode.
    /// - Returns: A Boolean indicating whether the next mode should be unlocked.
    func shouldUnlockNextMode(levelCompleted: Int?, currentModeLevel: Int) -> Bool {
        guard let levelCompleted = levelCompleted else { return false }
        
        let unlockConditions: [GameMode: (level: Int, requiredModeLevel: Int)] = [
            .add: (1, 0),
            .subtract: (10, 1),
            .hybrid: (-1, -1) // -1 or another sentinel value to indicate no unlock
        ]
        
        guard let condition = unlockConditions[mode] else { return false }
        
        return levelCompleted == condition.level && currentModeLevel == condition.requiredModeLevel
    }
}



// MARK: - Dependencies
/// Protocol defining the necessary properties and methods for a game data store.
public protocol GameStore {
    /// The current level of the game mode.
    var modeLevel: Int { get }
    
    /// Saves a `PerformanceRecord`.
    /// - Parameter record: The `PerformanceRecord` to save.
    func save(record: PerformanceRecord)

    /// Loads the high score for a specific game mode.
    /// - Parameter mode: The game mode for which to load the high score.
    /// - Returns: The high score as an integer.
    func loadHighScore(mode: GameMode) async -> Int

    /// Loads the total number of completed levels for a specific game mode.
    /// - Parameter mode: The game mode for which to load the level count.
    /// - Returns: The total number of completed levels as an integer.
    func loadTotalCompletedLevelsCount(mode: GameMode) -> Int

    /// Loads the unlocked achievements for a specific game mode.
    /// - Parameter mode: The game mode for which to load achievements.
    /// - Returns: An array of `GameAchievement`.
    func loadUnlockedAchievements(mode: GameMode) async -> [GameAchievement]
}


// MARK: - Extension Dependencies
/// Extension of `LevelResults` to provide additional functionalities specific to `GameManager`.
fileprivate extension LevelResults {
    /// Determines if the level was completed.
    /// - Returns: The completed level number if the level was completed, otherwise nil.
    var levelCompleted: Int? {
        return didCompleteLevel ? level : nil
    }
    
    /// Converts the `LevelResults` to `ResultAchievementInfo` format.
    /// - Parameters:
    ///   - modeName: The name of the game mode.
    ///   - completedLevelCount: The total number of completed levels.
    /// - Returns: An instance of `ResultAchievementInfo`.
    func toAchievementInfo(modeName: String, completedLevelCount: Int) -> ResultAchievementInfo {
        return .init(
            modeName: modeName,
            totalCompletedLevelCount: completedLevelCount,
            levelCompleted: levelCompleted,
            perfectStreakCount: perfectStreakCount,
            completionTime: completionTime
        )
    }
}
