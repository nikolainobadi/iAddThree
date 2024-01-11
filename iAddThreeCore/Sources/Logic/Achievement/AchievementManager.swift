//
//  AchievementManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

/// `AchievementManager` is responsible for managing the game achievements.
/// It provides functionalities to retrieve and check the status of achievements based on the game results.
enum AchievementManager {

    /// Retrieves a list of achievements based on the results of a game level.
    /// - Parameter info: `ResultAchievementInfo` containing details about the game level and player's performance.
    /// - Returns: An array of `GameAchievement` that the player has earned in the level.
    static func getAchievements(info: ResultAchievementInfo) -> [GameAchievement] {
        let achievementsForMode = AchievementConfigurator.generateAchievements(modeName: info.modeName.lowercased())
        return achievementsForMode.compactMap { metadata in
            guard checkAchievement(metadata, withInfo: info) else { return nil }
            return GameAchievement(identifier: metadata.identifier)
        }
    }
}


// MARK: - Private Methods
private extension AchievementManager {
    /// Checks if the player has met the criteria for a specific achievement.
    /// - Parameters:
    ///   - achievement: `AchievementMetadata` to check against.
    ///   - info: `ResultAchievementInfo` containing details about the game level and player's performance.
    /// - Returns: A Boolean value indicating whether the achievement criteria is met.
    static func checkAchievement(_ achievement: AchievementMetadata, withInfo info: ResultAchievementInfo) -> Bool {
        switch achievement.requirement {
        case .level(let requiredLevel):
            guard let levelCompleted = info.levelCompleted else { return false }
            
            return levelCompleted == requiredLevel
        case .time(let maxTime):
            guard let completionTime = info.completionTime else { return false }
            
            return completionTime <= maxTime
        case .perfectScoreStreak(let requiredStreak):
            return info.perfectStreakCount == requiredStreak
        case .totalCompletedLevelCount(let requiredCount):
            return info.totalCompletedLevelCount == requiredCount
        }
    }
}
