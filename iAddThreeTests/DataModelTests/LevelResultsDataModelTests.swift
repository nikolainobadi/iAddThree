//
//  LevelResultsDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import XCTest
import Combine
@testable import iAddThree

final class LevelResultsDataModelTests: XCTestCase {
    private var changes = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        
        changes.removeAll()
        XCTAssertTrue(changes.isEmpty)
    }
}


// MARK: - Unit Tests
extension LevelResultsDataModelTests {
    func test_init_startingValues() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.currentScore, 0)
        XCTAssertFalse(sut.showingButton)
        XCTAssertFalse(sut.showingViews)
        XCTAssertEqual(sut.currentLevel, 1)
        XCTAssertEqual(sut.nextLevel, 2)
        XCTAssertNil(sut.newScore)
    }
    
    func test_completedLevel_noPointsToAdd_returnsFalse() {
        XCTAssertFalse(makeSUT().completedLevel)
    }
    
    func test_completedLevel_withPointsToAdd_returnsTrue() {
        XCTAssertTrue(makeSUT(results: makeResults(pointsToAdd: 1)).completedLevel)
    }
    
    func test_playAgainText_noPointsToAdd() {
        XCTAssertEqual(makeSUT().playAgainText, "Try Again?")
    }
    
    func test_playAgainText_withPointsToAdd() {
        XCTAssertNotEqual(makeSUT(results: makeResults(pointsToAdd: 1)).playAgainText, "Try Again?")
    }
    
    func test_showResults() {
        let sut = makeSUT()
        
        sut.showResults()
        
        XCTAssertTrue(sut.showingViews)
    }
    
    func test_showResults_noPointsToAdd_triggersShowButton() {
        let exp = expectation(description: "waiting for showButtons")
        let sut = makeSUT()
        
        sut.$showingButton
            .dropFirst()
            .sink { XCTAssertTrue($0); exp.fulfill() }
            .store(in: &changes)
        
        sut.showResults()
        
        waitForExpectations(timeout: 2.1)
    }
    
    func test_showResults_withPointsToAdd_newScoreSet() {
        let exp = expectation(description: "waiting for showButtons")
        let currentScore = 0
        let pointsToAdd = 4
        let sut = makeSUT(results: makeResults(currentScore: currentScore, pointsToAdd: pointsToAdd))
        
        sut.$newScore
            .drop(while: { $0 == nil })
            .sink { XCTAssertEqual($0, pointsToAdd); exp.fulfill() }
            .store(in: &changes)
        
        sut.showResults()
        
        waitForExpectations(timeout: 1.1)
    }
    
    func test_playAgain() {
        let exp = expectation(description: "waiting for playAgain")
        let sut = makeSUT(playAgain: { exp.fulfill() })
        
        sut.playAgain()
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension LevelResultsDataModelTests {
    func makeSUT(results: LevelResults? = nil, playAgain: @escaping () -> Void = { }) -> LevelResultsDataModel {
        LevelResultsDataModel(results: results ?? makeResults(), playAgain: playAgain)
    }
    
    func makeResults(currentScore: Int = 0, pointsToAdd: Int = 0, currentLevel: Int = 1, timerFinished: Bool = false) -> LevelResults {
        LevelResults(currentScore: currentScore, pointsToAdd: pointsToAdd, currentLevel: currentLevel, timerFinished: timerFinished)
    }
}
