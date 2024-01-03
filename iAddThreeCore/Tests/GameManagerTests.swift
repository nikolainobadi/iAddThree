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
}


// MARK: - SUT
extension GameManagerTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: GameManager, store: MockStore) {
        let store = MockStore()
        let sut = GameManager(store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
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
