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
        
        XCTAssertNil(store.highScore)
        XCTAssertTrue(sut.currentHighScore == 0)
        XCTAssertTrue(sut.unlockedAchievements.isEmpty)
    }
    
    func test_saveResults_scoreIsGreaterThanCurrentHighScore_newScoreSaved() {
        let score = 4
        let results = makeResults(score: score)
        let (sut, store) = makeSUT()
        
        sut.saveResults(results)
        
        XCTAssertEqual(store.highScore, score)
    }
    
    func test_saveResults_scoreIsLessThanCurrentHighScore_oldHighScoreRemains() {
        let score = 4
        let currentHighScore = 10
        let results = makeResults(score: score)
        let (sut, store) = makeSUT(currentHighScore: currentHighScore)
        
        sut.saveResults(results)
        
        XCTAssertEqual(store.highScore, nil)
    }
}


// MARK: - SUT
extension GameManagerTests {
    func makeSUT(currentHighScore: Int = 0, unlockedAchievements: [GameAchievement] = [], file: StaticString = #filePath, line: UInt = #line) -> (sut: GameManager, store: MockStore) {
        let store = MockStore()
        let sut = GameManager(store: store, currentHighScore: currentHighScore, unlockedAchievements: unlockedAchievements)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
    
    func makeResults(score: Int = 0, didCompleteLevel: Bool = true, completionTime: TimeInterval = 10) -> LevelResults {
        return .init(score: score, level: 0, didCompleteLevel: didCompleteLevel, completionTime: completionTime)
    }
}


// MARK: - Helper Classes
extension GameManagerTests {
    class MockStore: GameStore {
        private(set) var highScore: Int?

        func saveHighScore(_ score: Int) {
            self.highScore = score
        }
    }
}
