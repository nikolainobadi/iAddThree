//
//  AchievementManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

enum AchievementManager {
    static func getAchievements(info: ResultAchievementInfo) -> [GameAchievement] {
        let achievementsForMode = AchievementConfigurator.generateAchievements(modeName: info.mode.name)

        return achievementsForMode.compactMap { metadata in
            checkAchievement(metadata, withInfo: info) ? GameAchievement(identifier: metadata.identifier) : nil
        }
    }
}


// MARK: - Private Methods
private extension AchievementManager {
    static func checkAchievement(_ achievement: AchievementMetadata, withInfo info: ResultAchievementInfo) -> Bool {
        switch achievement.requirement {
        case .level(let requiredLevel):
            return info.levelCompleted >= requiredLevel
        case .time(let maxTime):
            return info.completionTime <= maxTime
        case .playCount(let requiredCount):
            return info.modePlayCount >= requiredCount
        case .perfectScoreStreak(let requiredStreak):
            return info.perfectStreakCount == requiredStreak
        }
    }
}
