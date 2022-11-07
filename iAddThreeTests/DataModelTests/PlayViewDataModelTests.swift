//
//  PlayViewDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/7/22.
//

import XCTest
@testable import iAddThree

final class PlayViewDataModelTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let (sut, updater) = makeSUT()
        
        XCTAssertEqual(updater.score, 0)
        XCTAssertNil(sut.results)
        XCTAssertNil(sut.error)
        XCTAssertEqual(sut.numberList.count, 4)
        XCTAssertFalse(sut.timerActive)
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.highScore, 0)
        XCTAssertEqual(sut.level, 1)
        XCTAssertEqual(sut.startTime, 0)
    }
    
    func test_startLevel_firstLevel_timerActiveIsFalse() {
        let sut = makeSUT().sut
        
        sut.startLevel()
        
        XCTAssertFalse(sut.timerActive)
    }
    
    func test_startLevel_secondLevel_timerActive() {
        let sut = makeSUT(info: makeInfo(level: 2)).sut
        
        sut.startLevel()
        
        XCTAssertTrue(sut.timerActive)
    }
    
    func test_submitNumber_answersFilledFromLeftToRight() async throws {
        let sut = makeSUT().sut
        let answers = ["1", "2", "3", "4"]

        sut.startLevel()
        
        answers.forEach { sut.submitNumber($0) }
        
        try await waitForAsyncMethod() // since an async call is made to updater

        zip(sut.numberList, answers).forEach { XCTAssertEqual($0.userAnswer, $1) }
    }
    
    func test_submitNumber_furtherSubmitsHaveNoEffectOnNumberList() async throws {
        let sut = makeSUT().sut
        let answers = ["1", "2", "3", "4"]
        let moreAnswers = ["5", "6", "7", "8"]

        sut.startLevel()
        answers.forEach { sut.submitNumber($0) }
        moreAnswers.forEach { sut.submitNumber($0) }
        
        try await waitForAsyncMethod() // since an async call is made to updater
        
        zip(sut.numberList, answers).forEach { XCTAssertEqual($0.userAnswer, $1) }
    }
    
    func test_submitNumber_finishLevel_resultsPosted() async throws {
        let sut = makeSUT().sut
        let answers = ["1", "2", "3", "4"]

        sut.startLevel()
        
        answers.forEach { sut.submitNumber($0) }
        
        try await waitForAsyncMethod() // since an async call is made to updater
        
        guard let results = sut.results else { return XCTFail("expected results") }
        
        XCTAssertFalse(results.timerFinished)
    }
    
    func test_submitNumber_finishLevel_showResultsCalled() {
        let exp = expectation(description: "waiting for showResults")
        let list = [NumberItem(number: 0, answer: 3)]
        let (sut, _) = makeSUT(list: list, showResults: { results in
            XCTAssertFalse(results.timerFinished)
            XCTAssertEqual(results.pointsToAdd, 1)
            XCTAssertEqual(results.currentLevel, 1)
            XCTAssertEqual(results.currentScore, 0)
            exp.fulfill()
        })
    
        sut.startLevel()
        sut.submitNumber("3")
        
        waitForExpectations(timeout: 2.1)
    }
    
    func test_submitNumber_finshedLevel_errorWhenSavingProgress() async throws {
        let sut = makeSUT(throwError: true).sut
        let answers = ["1", "2", "3", "4"]

        sut.startLevel()
        
        answers.forEach { sut.submitNumber($0) }
        
        try await waitForAsyncMethod() // since an async call is made to updater
        
        XCTAssertNotNil(sut.error)
    }
    
    func test_timesUp_answersNotAllFilled() async throws {
        let sut = makeSUT(info: makeInfo(level: 2)).sut
        
        sut.startLevel()
        
        try await waitForAsyncMethod()
        
        sut.timerActive = false // to mock timer running out
        
        try await waitForAsyncMethod()
        
        guard let results = sut.results else { return XCTFail("expected results") }
        
        XCTAssertTrue(results.timerFinished)
    }
    
    func test_timesUp_errorWhenSavingProgress() async throws {
        
    }
}


// MARK: - SUT
extension PlayViewDataModelTests {
    func makeSUT(list: [NumberItem]? = nil, info: LevelInfo? = nil, throwError: Bool = false, showResults: @escaping (LevelResults) -> Void = { _ in },  file: StaticString = #filePath, line: UInt = #line) -> (sut: PlayViewDataModel, updater: MockUpdater) {
        
        let list = list ?? makeList(.add)
        let info = info ?? makeInfo()
        let updater = MockUpdater(throwError: throwError)
        let sut = PlayViewDataModel(numberList: list, info: info, updater: updater, showResults: showResults)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, updater)
    }
    
    func makeList(_ mode: GameMode) -> [NumberItem] {
        NumberItemFactory.makeNumberList(mode)
    }
    
    func makeInfo(score: Int = 0, level: Int = 1, highScore: Int = 0) -> LevelInfo {
        LevelInfo(score: score, level: level, highScore: highScore)
    }
}


// MARK: - Helper Classes
extension PlayViewDataModelTests {
    class MockUpdater: ScoreUpdater {
        private let throwError: Bool
        var score = 0
        
        init(throwError: Bool) {
            self.throwError = throwError
        }
        
        func updateScore(newScore: Int) async throws {
            if throwError { throw NSError(domain: "Test", code: 1) }
            
            score = newScore
        }
    }
}
