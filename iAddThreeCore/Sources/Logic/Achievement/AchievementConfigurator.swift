//
//  AchievementConfigurator.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

enum AchievementConfigurator {
    static func generateAchievements(modeName: String) -> [AchievementMetadata] {
        return [
            AchievementMetadata(identifier: "\(modeName)_level_1", requirement: .level(1)),
            AchievementMetadata(identifier: "\(modeName)_level_10", requirement: .level(10)),
            AchievementMetadata(identifier: "\(modeName)_level_30", requirement: .level(30)),
            AchievementMetadata(identifier: "\(modeName)_quick_completion", requirement: .time(5)),
            AchievementMetadata(identifier: "\(modeName)_frequent_player", requirement: .completedLevelCount(100)),
            AchievementMetadata(identifier: "\(modeName)_perfect_streak", requirement: .perfectScoreStreak(10))
        ]
    }
}
