//
//  GameManagerTests.swift
//  iAddThreeCoreTests
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import XCTest
@testable import iAddThreeCore

final class GameManagerTests: XCTestCase {
    func test_init_startingValues() {
        let (sut, store) = makeSUT()
        
        XCTAssertNil(store.savedScore)
        XCTAssertFalse(store.didIncrementLevel)
        XCTAssertEqual(sut.currentHighScore, 0)
    }
}


// MARK: - HighScore
extension GameManagerTests {
    func test_saveResults_scoreIsGreaterThanCurrentHighScore_newScoreSaved() {
        let normalPoints = 4
        let results = makeResults(normalPoints: normalPoints)
        let (sut, store) = makeSUT()
        
        sut.saveResults(results)
        
        XCTAssertEqual(store.savedScore, normalPoints)
    }
    
    func test_saveResults_scoreIsGreaterThanCurrentHighScore_currentHighScoreUpdated() {
        let normalPoints = 4
        let results = makeResults(normalPoints: normalPoints)
        let sut = makeSUT().sut
        
        sut.saveResults(results)
        
        XCTAssertEqual(sut.currentHighScore, normalPoints)
    }
    
    func test_saveResults_scoreIsLessThanCurrentHighScore_oldHighScoreRemains() {
        let normalPoints = 4
        let currentHighScore = 10
        let results = makeResults(normalPoints: normalPoints)
        let (sut, store) = makeSUT(currentHighScore: currentHighScore)
        
        sut.saveResults(results)
        
        XCTAssertNil(store.savedScore)
    }
    
    func test_saveResults_scoreIsLessThanCurrentHighScore_currentHighScoreRemainsSame() {
        let normalPoints = 4
        let currentHighScore = 10
        let results = makeResults(normalPoints: normalPoints)
        let sut = makeSUT(currentHighScore: currentHighScore).sut
        
        sut.saveResults(results)
        
        XCTAssertEqual(sut.currentHighScore, currentHighScore)
    }
}


// MARK: - ModeLevel
extension GameManagerTests {
    func test_saveResults_addMode_completingFirstLevel_firstTime_incrementsModeLevel() {
        let results = makeResults()
        let (sut, store) = makeSUT(mode: .add)

        sut.saveResults(results)

        XCTAssertTrue(store.didIncrementLevel)
    }

    
    func test_saveResults_addMode_completingFirstLevel_notFirstTime_doesNotIncrementModeLevel() {
        let results = makeResults()
        let (sut, store) = makeSUT(mode: .add, modeLevel: 1)

        sut.saveResults(results)

        XCTAssertFalse(store.didIncrementLevel)
    }

    func test_saveResults_addMode_completingLevelsAfterFirst_doesNotIncrementModeLevel() {
        for level in 2...30 {
            let results = makeResults(level: level)
            let (sut, store) = makeSUT(mode: .add, modeLevel: 1) // Assuming modeLevel is already incremented once for the first level

            sut.saveResults(results)

            XCTAssertFalse(store.didIncrementLevel, "Mode level should not increment after completing level \(level) in add mode.")
        }
    }
    
    func test_saveResults_subtractMode_completingFirst9Levels_doesNotIncrementModeLevel() {
        for level in 1...9 {
            let results = makeResults(level: level)
            let (sut, store) = makeSUT(mode: .subtract)

            sut.saveResults(results)

            XCTAssertFalse(store.didIncrementLevel)
        }
    }

    func test_saveResults_subtractMode_completingLevel10_firstTime_incrementsModeLevel() {
        let results = makeResults(level: 10)
        let (sut, store) = makeSUT(mode: .subtract, modeLevel: 1)

        sut.saveResults(results)

        XCTAssertTrue(store.didIncrementLevel)
    }

    func test_saveResults_subtractMode_completingLevel10_notFirstTime_doesNotIncrementModeLevel() {
        let results = makeResults(level: 10)
        let (sut, store) = makeSUT(mode: .subtract, modeLevel: 2) // modeLevel 2 indicates not first time

        sut.saveResults(results)

        XCTAssertFalse(store.didIncrementLevel)
    }
    
    func test_saveResults_subtractMode_completingLevelsAfter10_doesNotIncrementModeLevel() {
        for level in 11...30 {
            let results = makeResults(level: level)
            let (sut, store) = makeSUT(mode: .subtract, modeLevel: 2) // Assuming modeLevel is already incremented once

            sut.saveResults(results)

            XCTAssertFalse(store.didIncrementLevel, "Mode level should not increment after completing level \(level) in subtract mode.")
        }
    }
}


// MARK: - SUT
extension GameManagerTests {
    func makeSUT(mode: GameMode = .add, modeLevel: Int = 0, currentHighScore: Int = 0, totalCompletedLevelsCount: Int = 0, unlockedAchievements: [GameAchievement] = [], file: StaticString = #filePath, line: UInt = #line) -> (sut: GameManager, store: MockStore) {
       let store = MockStore(modeLevel: modeLevel, highScore: currentHighScore, totalCompletedLevelsCount: totalCompletedLevelsCount, unlockedAchievements: unlockedAchievements)
        let sut = GameManager(mode: mode, store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
    
    func makeResults(normalPoints: Int = 0, level: Int = 1, perfectStreakCount: Int = 0, completionTime: TimeInterval? = 10) -> LevelResults {
        return .init(level: level, normalPoints: normalPoints, bonusPoints: nil, didCompleteLevel: completionTime != nil, perfectStreakCount: perfectStreakCount, completionTime: completionTime)
    }
}


// MARK: - Helper Classes
extension GameManagerTests {
    class MockStore: GameStore {
        private let highScore: Int
        private let totalCompletedLevelsCount: Int
        private let unlockedAchievements: [GameAchievement]
        
        private(set) var savedScore: Int?
        private(set) var didIncrementLevel = false
        
        var modeLevel: Int
        
        init(modeLevel: Int, highScore: Int, totalCompletedLevelsCount: Int, unlockedAchievements: [GameAchievement]) {
            self.modeLevel = modeLevel
            self.highScore = highScore
            self.totalCompletedLevelsCount = totalCompletedLevelsCount
            self.unlockedAchievements = unlockedAchievements
        }
        
        func getTotalCompletedLevelsCount(modeId: String) -> Int {
            return totalCompletedLevelsCount
        }
        
        func getHighScore(modeId: String) -> Int {
            return highScore
        }
        
        func loadUnlockedAchievements(modeId: String) -> [GameAchievement] {
            return unlockedAchievements
        }

        func saveRecord(record: PerformanceRecord) {
            self.savedScore = record.newHighScore
            self.didIncrementLevel = record.shouldUnlockNextMode
        }
    }
}
