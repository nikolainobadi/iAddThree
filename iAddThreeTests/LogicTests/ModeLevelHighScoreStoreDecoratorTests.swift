//
//  ModeLevelHighScoreStoreDecoratorTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/17/22.
//

import XCTest
@testable import iAddThree

final class ModeLevelHighScoreStoreDecoratorTests: XCTestCase {
    func test_init_startingValues() {
        let (sut, store, defaults) = makeSUT()
        
        XCTAssertEqual(store.highScore, 0)
        XCTAssertEqual(sut.highScore, store.highScore)
        XCTAssertEqual(defaults.integer(forKey: AppStorageKey.modeLevel), 0)
    }
    
    func test_highScore() {
        let highScore = 10
        let (sut, store, _) = makeSUT(highScore: highScore)
        
        XCTAssertEqual(store.highScore, highScore)
        XCTAssertEqual(sut.highScore, store.highScore)
    }
    
    func test_updateHighScore_addMode_furtherUpdatesToHighScoreHaveNoSideEffect() async throws {
        let highScore = 1
        let (sut, store, defaults) = makeSUT(mode: .add)

        try await sut.saveHighScore(highScore)
        try await waitForAsyncMethod()
        
        XCTAssertEqual(store.highScore, highScore)
        XCTAssertEqual(sut.highScore, store.highScore)
        XCTAssertEqual(defaults.integer(forKey: AppStorageKey.modeLevel), 1)
        
        let newHighScore = 2
        
        try await sut.saveHighScore(newHighScore)
        try await waitForAsyncMethod()
        
        XCTAssertEqual(store.highScore, newHighScore)
        XCTAssertEqual(sut.highScore, store.highScore)
        XCTAssertEqual(defaults.integer(forKey: AppStorageKey.modeLevel), 1)
    }
    
    func test_updateHighScore_subtractMode_lessThanTenHasNoEffect() async throws {
        let highScore = 9
        let (sut, store, defaults) = makeSUT(mode: .subtract)

        try await sut.saveHighScore(highScore)
        try await waitForAsyncMethod()
        
        XCTAssertEqual(store.highScore, highScore)
        XCTAssertEqual(sut.highScore, store.highScore)
        XCTAssertEqual(defaults.integer(forKey: AppStorageKey.modeLevel), 1)
    }
    
    func test_updateHighScore_subtractMode_furtherUpdatesToHighScoreHaveNoSideEffect() async throws {
        let highScore = 10
        let (sut, store, defaults) = makeSUT(mode: .subtract)

        try await sut.saveHighScore(highScore)
        try await waitForAsyncMethod()
        
        XCTAssertEqual(store.highScore, highScore)
        XCTAssertEqual(sut.highScore, store.highScore)
        XCTAssertEqual(defaults.integer(forKey: AppStorageKey.modeLevel), 2)
        
        let newHighScore = 11
        
        try await sut.saveHighScore(newHighScore)
        try await waitForAsyncMethod()
        
        XCTAssertEqual(store.highScore, newHighScore)
        XCTAssertEqual(sut.highScore, store.highScore)
        XCTAssertEqual(defaults.integer(forKey: AppStorageKey.modeLevel), 2)
    }
}


// MARK: - SUT
extension ModeLevelHighScoreStoreDecoratorTests {
    func makeSUT(mode: GameMode = .add, highScore: Int = 0, file: StaticString = #filePath, line: UInt = #line) -> (sut: HighScoreStore, store: HighScoreStore, defaults: UserDefaults) {
        
        let defaults = makeUserDefaults(mode == .add ? 0 : 1)
        let store = SinglePlayHighScoreStore(highScore: highScore)
        let sut = ModeLevelHighScoreStoreDecorator(mode: mode, decoratee: store, defaults: defaults)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store, defaults)
    }
    
    func makeUserDefaults(_ modeLevel: Int) -> UserDefaults {
        let defaults = UserDefaults(suiteName: #file)!
        defaults.removePersistentDomain(forName: #file)
        defaults.set(modeLevel, forKey: AppStorageKey.modeLevel)
        return defaults
    }
}
