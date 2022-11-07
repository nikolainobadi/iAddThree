//
//  GameModeMenuDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/7/22.
//

import XCTest
@testable import iAddThree

final class GameModeMenuDataModelTests: XCTestCase {
    func test_init_startingValues() {
        let (sut, resetHandler) = makeSUT()
        
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.highScore, 0)
        XCTAssertFalse(resetHandler.didResetScore)
    }
    
    func test_resetHighScore() async throws {
        let highScore = 4
        let (sut, resetHandler) = makeSUT(highScore: highScore)
        
        XCTAssertEqual(sut.highScore, highScore)
        
        sut.resetHighScore()
        
        try await waitForAsyncMethod() // since resetHandler is async
        
        XCTAssertTrue(resetHandler.didResetScore)
        XCTAssertEqual(sut.highScore, 0)
    }
    
    func test_resetHighScore_error() async throws {
        let highScore = 4
        let (sut, resetHandler) = makeSUT(highScore: highScore, throwError: true)
        
        XCTAssertEqual(sut.highScore, highScore)
        
        sut.resetHighScore()
        
        try await waitForAsyncMethod() // since resetHandler is async
        
        XCTAssertFalse(resetHandler.didResetScore)
        XCTAssertEqual(sut.highScore, highScore)
        XCTAssertNotNil(sut.error)
    }
}


// MARK: - SUT
extension GameModeMenuDataModelTests {
    func makeSUT(highScore: Int = 0, throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: GameModeMenuDataModel, resetHandler: MockResetHandler) {
        
        let resetHandler = MockResetHandler(throwError: throwError)
        let sut = GameModeMenuDataModel(resetHandler: resetHandler, highScore: highScore)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, resetHandler)
    }
}


// MARK: - Helper Classes
extension GameModeMenuDataModelTests {
    class MockResetHandler: ScoreResetHandler {
        private let throwError: Bool
        var didResetScore = false
        
        init(throwError: Bool) {
            self.throwError = throwError
        }
        
        func resetHighScore() async throws {
            if throwError { throw NSError(domain: "Test", code: 1) }
            
            didResetScore = true
        }
    }
}
