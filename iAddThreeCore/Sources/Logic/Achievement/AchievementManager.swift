//
//  AchievementManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

enum AchievementManager {
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
