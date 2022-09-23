//
//  PlayViewDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import XCTest
@testable import iAddThree

final class PlayViewDataModelTests: XCTestCase {
    func test_init_numberListFilled_allAnswersEmpty() {
        let sut = makeSUT()
        
        XCTAssertFalse(sut.numberList.isEmpty)
        XCTAssertTrue(sut.numberList.filter({ $0.userAnswer != nil }).isEmpty)
    }
    
    func test_submitAnswer_answersFilledFromLeftToRight() {
        let sut = makeSUT()
        let answers = ["1", "2", "3", "4"]

        answers.forEach { sut.submitAnswer($0) }
        
        zip(sut.numberList, answers).forEach { XCTAssertEqual($0.userAnswer, $1) }
    }
    
    func test_submitAnswer_furtherSubmitsHaveNoEffectOnNumberList() {
        let sut = makeSUT()
        let answers = ["1", "2", "3", "4"]
        let moreAnswers = ["5", "6", "7", "8"]

        answers.forEach { sut.submitAnswer($0) }
        moreAnswers.forEach { sut.submitAnswer($0) }
        
        zip(sut.numberList, answers).forEach { XCTAssertEqual($0.userAnswer, $1) }
    }
    
    func test_submitAnswer_onFinalSubmitFinishedIsCalled_pointsToAddMatchesCorrectAnswerCount() {
        let numberList = NumberItem.defaultList
        let correctAnswers = numberList.map { "\($0.answer)" }
        let moreAnswers = ["5", "6", "7", "8"]
        let exp = expectation(description: "waiting for finished")
        let inverted = expectation(description: "inverted")
        inverted.isInverted = true
    
        var finishedCount = 0
        
        let sut = makeSUT(numberList: numberList, finished: { pointsToAdd in
            if finishedCount == 0 {
                finishedCount += 1
                XCTAssertEqual(pointsToAdd, 4)
                exp.fulfill()
            } else {
                XCTFail("unexpected call to completion")
            }
        })
        
        correctAnswers.forEach { sut.submitAnswer($0) }
        
        wait(for: [exp], timeout: 0.1)
        
        moreAnswers.forEach { sut.submitAnswer($0) }
        
        wait(for: [inverted], timeout: 0.1)
    }
}


// MARK: - SUT
extension PlayViewDataModelTests {
    func makeSUT(numberList: [NumberItem] = NumberItem.defaultList, finished: @escaping (Int) -> Void = { _ in }, file: StaticString = #filePath, line: UInt = #line) -> PlayViewDataModel {
        
        return PlayViewDataModel(numberList: numberList.map({ NumberItemPresenter($0) }), finished: finished)
    }
}
