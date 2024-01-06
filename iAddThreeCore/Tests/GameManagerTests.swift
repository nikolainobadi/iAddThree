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
        XCTAssertNil(store.savedModeId)
        XCTAssertEqual(sut.currentHighScore, 0)
        XCTAssertTrue(sut.unlockedAchievements.isEmpty)
    }
    
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


// MARK: - SUT
extension GameManagerTests {
    func makeSUT(modeId: String = "Add Three", currentHighScore: Int = 0, file: StaticString = #filePath, line: UInt = #line) -> (sut: GameManager, store: MockStore) {
        let store = MockStore(highScore: currentHighScore)
        let sut = GameManager(modeId: modeId, store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
    
    func makeResults(normalPoints: Int = 0, didCompleteLevel: Bool = true, completionTime: TimeInterval = 10) -> LevelResults {
        return .init(level: 1, normalPoints: normalPoints, bonusPoints: nil, didCompleteLevel: didCompleteLevel, completionTime: completionTime)
    }
}


// MARK: - Helper Classes
extension GameManagerTests {
    class MockStore: GameStore {
        private let highScore: Int
        private(set) var savedScore: Int?
        private(set) var savedModeId: String?
        
        init(highScore: Int) {
            self.highScore = highScore
        }
        
        func getHighScore(modeId: String) -> Int {
            return highScore
        }

        func saveHighScore(_ score: Int, modeId: String) {
            savedScore = score
            savedModeId = modeId
        }
    }
}
