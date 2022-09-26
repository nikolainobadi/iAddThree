//
//  GameViewDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import XCTest
@testable import iAddThree

final class GameViewDataModelTests: XCTestCase {
    func test_init_modeTitle() {
        XCTAssertEqual(makeSUT().modeTitle, GameMode.add.title)
    }
    
    func test_loadResults_pointsToAdd_error() async {
        do {
            let sut = makeSUT(throwError: true)
            
            sut.numberList = makeAnsweredNumberList()
            
            _ = try await sut.loadResults()
            XCTFail("expected error but none were thrown")
        } catch { }
    }
    
    func test_loadResults_noPointsToAdd_resultsReturned() async throws {
        let results = try await makeSUT().loadResults()
        
        XCTAssertEqual(results.currentScore, 0)
        XCTAssertEqual(results.previousLevel, 1)
        XCTAssertNil(results.newScore)
    }
    
    func test_loadResults_pointsToAdd_resultsReturned() async throws {
        let sampleList = makeAnsweredNumberList()
        let expectedNewScore = sampleList.filter({ $0.isCorrect }).count
        let sut = makeSUT()
        
        sut.numberList = sampleList
        
        let results = try await sut.loadResults()
        
        XCTAssertEqual(results.currentScore, 0)
        XCTAssertEqual(results.previousLevel, 1)
        
        guard let newScore = results.newScore else {
            return XCTFail("expected a new score")
        }
        
        XCTAssertEqual(newScore, expectedNewScore)
    }
}


// MARK: - SUT
extension GameViewDataModelTests {
    func makeSUT(mode: GameMode = .add, throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> GameViewDataModel {
        
        let highScoreStore = MockStore(throwError: throwError)
        let store = GameStorageManager(store: highScoreStore)
        let sut = GameViewDataModel(mode: mode, store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
    
    func makeAnsweredNumberList() -> [NumberItemPresenter] {
        var list = [NumberItemPresenter(NumberItem(number: 0, answer: 3))]
        
        list[0].userAnswer = "3"
        
        return list
    }
}


// MARK: - Helper Classes
extension GameViewDataModelTests {
    class MockStore: HighScoreStore {
        private let throwError: Bool
        var highScore: Int = 0
        
        init(throwError: Bool) {
            self.throwError = throwError
        }
        
        func saveHighScore(_ newHighScore: Int) async throws {
            if throwError { throw NSError(domain: "test", code: 0) }
            highScore = newHighScore
        }
    }
}
