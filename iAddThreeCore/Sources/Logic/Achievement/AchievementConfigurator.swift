//
//  AchievementConfigurator.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

enum AchievementConfigurator {
    static func generateAchievements(modeName: String) -> [AchievementMetadata] {
        return [
            .init(identifier: "classic_\(modeName)_level_1", requirement: .level(1)),
            .init(identifier: "classic_\(modeName)_level_10", requirement: .level(10)),
            .init(identifier: "classic_\(modeName)_level_30", requirement: .level(30))
//            ,
//            .init(identifier: "classic_\(modeName)_quick_completion", requirement: .time(5)),
//            .init(identifier: "classic_\(modeName)_frequent_player", requirement: .totalCompletedLevelCount(100)),
//            .init(identifier: "classic_\(modeName)_perfect_streak", requirement: .perfectScoreStreak(10))
        ]
    }
}
