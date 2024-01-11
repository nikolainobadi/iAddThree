//
//  AchievementManagerTests.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import XCTest
@testable import iAddThreeCore

final class AchievementManagerTests: XCTestCase {
    func test_getAchievements_UnlocksCorrectLevelAchievements() {
        let sut = makeSUT()
        let levelsToTest = [1, 10, 30]
        
        for level in levelsToTest {
            let info = createResultAchievementInfo(levelCompleted: level)
            let achievements = sut.getAchievements(info: info)
            
            XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_level_\(level)" },
                          "Achievement for completing level \(level) should be unlocked.")
        }
    }

//    func test_getAchievements_withTimeRequirement_UnlocksCorrectly() {
//        let sut = makeSUT()
//        
//        for time in stride(from: 0.1, to: 5.0, by: 0.1) {
//            let info = createResultAchievementInfo(completionTime: time) // Test for each time from 0.1 to just below 5.0 seconds
//            let achievements = sut.getAchievements(info: info)
//
//            XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_quick_completion" },
//                          "Quick completion achievement should unlock if time requirement is met at \(time) seconds.")
//        }
//    }

//    func test_getAchievements_withCompletedLevelCountRequirement_UnlocksCorrectly() {
//        let sut = makeSUT()
//        let info = createResultAchievementInfo(totalCompletedLevelCount: 100)
//        let achievements = sut.getAchievements(info: info)
//
//        XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_frequent_player" }, "Expected to unlock 'add_frequent_player' achievement.")
//    }
    
//    func test_getAchievements_UnlocksMultipleAchievementsSimultaneously() {
//        let sut = makeSUT()
//        let info = createResultAchievementInfo(totalCompletedLevelCount: 100, levelCompleted: 30, perfectStreakCount: 10, completionTime: 4.0)
//        let achievements = sut.getAchievements(info: info)
//
//        XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_level_30" }, "Level 30 achievement should unlock.")
//        XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_quick_completion" }, "Quick completion achievement should unlock.")
//        XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_perfect_streak" }, "Perfect streak achievement should unlock.")
//        XCTAssertTrue(achievements.contains { $0.identifier == "classic_add_frequent_player" }, "Frequent player achievement should unlock.")
//    }
}


// MARK: - NotUnlocked
extension AchievementManagerTests {
    func test_getAchievements_withLevelRequirement_NotUnlockedWhenConditionNotMet() {
        let sut = makeSUT()
        let levelsToTest = Array(2...29).filter { $0 != 10 && $0 != 30 }
        let expectedIdentifiers = ["add_level_1", "add_level_10", "add_level_30"]

        for level in levelsToTest {
            let info = createResultAchievementInfo(levelCompleted: level)
            let achievements = sut.getAchievements(info: info)

            for identifier in expectedIdentifiers {
                XCTAssertFalse(achievements.contains { $0.identifier == identifier },
                               "Achievement \(identifier) should not be unlocked at level \(level).")
            }
        }
    }

    func test_getAchievements_withTimeRequirement_NotUnlockedWhenConditionNotMet() {
        let sut = makeSUT()
        
        for time in stride(from: 5.1, through: 10.0, by: 0.1) {
            let info = createResultAchievementInfo(completionTime: time) // Test for each time from 5.1 to 10.0 seconds
            let achievements = sut.getAchievements(info: info)

            XCTAssertFalse(achievements.contains { $0.identifier == "add_quick_completion" },
                           "Quick completion achievement should not unlock if time requirement is not met at \(time) seconds.")
        }
    }

    func test_getAchievements_withPerfectScoreStreakRequirement_NotUnlockedWhenConditionNotMet() {
        let sut = makeSUT()
        
        for streakCount in 0..<10 {
            let info = createResultAchievementInfo(perfectStreakCount: streakCount)
            let achievements = sut.getAchievements(info: info)

            XCTAssertFalse(achievements.contains { $0.identifier == "add_perfect_streak" },
                           "Perfect streak achievement should not unlock if streak count is \(streakCount).")
        }
    }
    
    func test_getAchievements_withTotalCompletedLevelCountRequirement_NotUnlockedWhenConditionNotMet() {
        let sut = makeSUT()
        
        for levelCount in 0..<100 {
            let info = createResultAchievementInfo(totalCompletedLevelCount: levelCount)
            let achievements = sut.getAchievements(info: info)

            XCTAssertFalse(achievements.contains { $0.identifier == "add_frequent_player" },
                           "Frequent player achievement should not unlock if total completed level count is \(levelCount).")
        }
    }
    
    func test_getAchievements_withTotalCompletedLevelCountRequirement_NotUnlockedWhenConditionForValuesOver100() {
        let sut = makeSUT()

        for levelCount in 101...110 { // Test a range over 100
            let info = createResultAchievementInfo(totalCompletedLevelCount: levelCount)
            let achievements = sut.getAchievements(info: info)

            XCTAssertFalse(achievements.contains { $0.identifier == "add_frequent_player" },
                          "Frequent player achievement should remain unlocked for \(levelCount) total completed levels.")
        }
    }
    
    func test_getAchievements_LevelAchievement_NotUnlockedWhenLevelNotCompleted() {
        let sut = makeSUT()
        let info = createResultAchievementInfo(levelCompleted: nil, completionTime: nil)
        let achievements = sut.getAchievements(info: info)

        XCTAssertFalse(achievements.contains { $0.identifier.starts(with: "add_level_") },
                       "Level achievements should not unlock if no level is completed.")
    }

    func test_getAchievements_TimeAchievement_NotUnlockedWhenLevelNotCompleted() {
        let sut = makeSUT()
        let info = createResultAchievementInfo(levelCompleted: nil, completionTime: nil)
        let achievements = sut.getAchievements(info: info)

        XCTAssertFalse(achievements.contains { $0.identifier == "add_quick_completion" },
                       "Quick completion achievement should not unlock if no level is completed.")
    }
}

// MARK: - SUT
private extension AchievementManagerTests {
    func makeSUT() -> AchievementManager.Type {
        return AchievementManager.self
    }
}


// MARK: - Helpers
private extension AchievementManagerTests {
    func createResultAchievementInfo(modeName: String = "add", totalCompletedLevelCount: Int = 0, levelCompleted: Int? = 1, perfectStreakCount: Int = 0, completionTime: TimeInterval? = 8) -> ResultAchievementInfo {
        return .init(modeName: modeName, totalCompletedLevelCount: totalCompletedLevelCount, levelCompleted: levelCompleted, perfectStreakCount: perfectStreakCount, completionTime: completionTime)
    }
}
