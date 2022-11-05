//
//  ScoreManagerTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/4/22.
//

import XCTest
@testable import iAddThree

final class ScoreManagerTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let (_, store, repo) = makeSUT()
        
        XCTAssertEqual(store.highScore, 0)
        XCTAssertEqual(repo.score, 0)
        XCTAssertEqual(repo.level, 1)
    }
    
    func test_updateScore_noNewHighScore() async throws {
        let newScore = 4
        let highScore = 10
        let (sut, store, repo) = makeSUT(highScore: highScore)
        
        try await sut.updateScore(newScore: newScore)
        
        XCTAssertEqual(repo.level, 2)
        XCTAssertEqual(repo.score, newScore)
        XCTAssertEqual(store.highScore, highScore)
    }
    
    func test_updateScore_noNewScore() async throws {
//        let newScore = 0
//        let highScore = 4
//        let (sut, store, repo) = makeSUT(highScore: highScore)
//
//        try await sut.updateScore(newScore: newScore)
//
//        XCTAssertEqual(repo.level, 1)
//        XCTAssertEqual(repo.score, 0)
//        XCTAssertEqual(store.highScore, highScore)
    }
    
    func test_updateScore_newHighScore() async throws {
        let newScore = 4
        let highScore = 0
        let (sut, store, repo) = makeSUT(highScore: highScore)
        
        try await sut.updateScore(newScore: newScore)
        
        XCTAssertEqual(repo.level, 2)
        XCTAssertEqual(repo.score, newScore)
        XCTAssertEqual(store.highScore, newScore)
    }
    
    func test_updateScore_resetScore() async throws {
        
    }
    
    func test_updateScore_error() async throws {
        let (sut, _, _) = makeSUT(throwError: true)
        
        do {
            try await sut.updateScore(newScore: 4)
            
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
    }
}


// MARK: - SUT
extension ScoreManagerTests {
    func makeSUT(highScore: Int = 0, throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: ScoreUpdater, highScoreStore: MockHighScoreStore, scoreRepo: LevelScoreStore) {
        
        let repo = LevelScoreRepository()
        let store = MockHighScoreStore(highScore: highScore, throwError: throwError)
        let sut = ScoreManager(highScoreStore: store, levelScoreStore: repo)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store, scoreRepo: repo)
    }
}


// MARK: - Helper Classes
extension ScoreManagerTests {
    class MockHighScoreStore: HighScoreStore {
        private let throwError: Bool
        
        var highScore: Int
        
        init(highScore: Int, throwError: Bool) {
            self.highScore = highScore
            self.throwError = throwError
        }
        
        func saveHighScore(_ newHighScore: Int) async throws {
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            highScore = newHighScore
        }
    }
}
