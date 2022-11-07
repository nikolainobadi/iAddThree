////
////  LevelResultsDataModelTests.swift
////  iAddThreeTests
////
////  Created by Nikolai Nobadi on 9/24/22.
////
//
//import XCTest
//@testable import iAddThree
//
//final class LevelResultsDataModelTests: XCTestCase {
//    func test_init_startingValuesEmpty() {
//        let sut = makeSUT()
//
//        XCTAssertEqual(sut.currentScore, 0)
//        XCTAssertFalse(sut.showingGameOver)
//    }
//
//    func test_completedLevel_noNewScore() {
//        XCTAssertFalse(makeSUT().completedLevel)
//    }
//
//    func test_completedLevel_withNewScore() {
//        XCTAssertTrue(makeSUT(newScore: 4).completedLevel)
//    }
//
//    func test_updateScore_noNewScore() {
//        let sut = makeSUT()
//
//        sut.updateScore()
//
//        XCTAssertTrue(sut.showingGameOver)
//    }
//
//    func test_updateScore_withNewScore() {
//        let newScore = 4
//        let sut = makeSUT(newScore: newScore)
//
//        sut.updateScore()
//
//        XCTAssertEqual(sut.currentScore, newScore)
//    }
//}
//
//
//// MARK: - SUT
//extension LevelResultsDataModelTests {
//    func makeSUT(currentScore: Int = 0, newScore: Int? = nil, previousLevel: Int = 1, playNextLevel: @escaping () -> Void = { }, file: StaticString = #filePath, line: UInt = #line) -> LevelResultsDataModel {
//
//        LevelResultsDataModel(currentScore: currentScore, newScore: newScore, previousLevel: previousLevel, playNextLevel: playNextLevel)
//    }
//}
