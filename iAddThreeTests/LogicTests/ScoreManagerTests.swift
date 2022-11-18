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
}


// MARK: - Updater Tests
extension ScoreManagerTests {
    func test_updateScore_noNewHighScore() async throws {
        let newScore = 4
        let highScore = 10
        let (sut, store, repo) = makeSUT(highScore: highScore)
        
        try await sut.updateScore(newScore: newScore)
        
        XCTAssertEqual(repo.level, 2)
        XCTAssertEqual(repo.score, newScore)
        XCTAssertEqual(store.highScore, highScore)
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


// MARK: - ResetHandler Tests
extension ScoreManagerTests {
    func test_resetHighScore() async throws {
        let score = 10
        let level = 5
        let (sut, store, repo) = makeSUT(score: score, level: level, highScore: score)
        
        XCTAssertEqual(repo.level, level)
        XCTAssertEqual(repo.score, score)
        XCTAssertEqual(store.highScore, score)
        
        try await sut.resetHighScore()
        
        XCTAssertEqual(repo.level, 1)
        XCTAssertEqual(repo.score, 0)
        XCTAssertEqual(store.highScore, 0)
    }
    
    func test_resetHighScore_error() async {
        let (sut, _, _) = makeSUT(throwError: true)
        
        do {
            try await sut.resetHighScore()
            
            XCTFail()
        } catch {
            XCTAssertTrue(true)
        }
    }
}


// MARK: - SUT
extension ScoreManagerTests {
    func makeSUT(score: Int = 0, level: Int = 1, highScore: Int = 0, throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: ScoreManager, highScoreStore: MockHighScoreStore, scoreRepo: LevelScoreStore) {
        
        let repo = makeScoreRepo(score: score, level: level)
        let store = MockHighScoreStore(highScore: highScore, throwError: throwError)
        let sut = ScoreManager(highScoreStore: store, levelScoreStore: repo)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store, scoreRepo: repo)
    }
    
    func makeScoreRepo(score: Int, level: Int) -> LevelScoreStore {
        let repo = GameContentViewDataModel()
        
        repo.score = score
        repo.level = level
        
        return repo
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
