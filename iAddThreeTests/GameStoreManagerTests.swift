//
//  GameStoreManagerTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 10/27/22.
//

import XCTest
@testable import iAddThree

final class GameStoreManagerTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.level, 1)
        XCTAssertEqual(sut.highScore, 0)
    }
    
    func test_resetHighScore_highScoreResetToZero() async throws {
        let highScore = 5
        let store = makeStore(highScore: highScore)
        let sut = makeSUT(store: store)
        
        XCTAssertEqual(sut.highScore, highScore)
        
        try await sut.resetHighScore()
        
        XCTAssertEqual(sut.highScore, 0)
    }
    
    func test_resetHighScore_currentScoreResetToZero() async throws {
        let currentScore = 5
        let sut = makeSUT(currentScore: currentScore)
        
        XCTAssertEqual(sut.score, currentScore)
        
        try await sut.resetHighScore()
        
        XCTAssertEqual(sut.score, 0)
    }
    
    func test_resetHighScore_currentLevelResetToOne() async throws {
        let currentLevel = 5
        let sut = makeSUT(currentLevel: currentLevel)
        
        XCTAssertEqual(sut.level, currentLevel)
        
        try await sut.resetHighScore()
        
        XCTAssertEqual(sut.level, 1)
    }
}


// MARK: - SUT
extension GameStoreManagerTests {
    func makeSUT(currentScore: Int = 0, currentLevel: Int = 1, store: HighScoreStore = SinglePlayHighScoreStore()) -> GameStorageManager {
        let sut = GameStorageManager(store: store)
        
        sut.score = currentScore
        sut.level = currentLevel
        
        return sut
    }
    
    
    func makeStore(highScore: Int = 0) -> HighScoreStore {
        let store = SinglePlayHighScoreStore()
        
        store.highScore = highScore
        
        return store
    }
}
