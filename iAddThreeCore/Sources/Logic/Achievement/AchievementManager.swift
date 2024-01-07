//
//  AchievementManager.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

enum AchievementManager {
    static func getAchievements(info: ResultAchievementInfo, previouslyUnlocked: [GameAchievement]) -> [GameAchievement] {
        let achievementsForMode = AchievementConfigurator.generateAchievements(modeName: info.modeName)
        let previouslyUnlockedIdentifiers = Set(previouslyUnlocked.map { $0.identifier })

        return achievementsForMode.compactMap { metadata in
            if !previouslyUnlockedIdentifiers.contains(metadata.identifier) && checkAchievement(metadata, withInfo: info) {
                return GameAchievement(identifier: metadata.identifier)
            }
            return nil
        }
    }
}


// MARK: - Private Methods
private extension AchievementManager {
    static func checkAchievement(_ achievement: AchievementMetadata, withInfo info: ResultAchievementInfo) -> Bool {
        switch achievement.requirement {
        case .level(let requiredLevel):
            guard let levelCompleted = info.levelCompleted else { return false }
            
            return levelCompleted >= requiredLevel
        case .time(let maxTime):
            guard let completionTime = info.completionTime else { return false }
            
            return completionTime <= maxTime
        case .perfectScoreStreak(let requiredStreak):
            return info.perfectStreakCount == requiredStreak
        case .completedLevelCount(let requiredCount):
            return info.completedLevelCount >= requiredCount
        }
    }
}
