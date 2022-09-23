//
//  PlayViewDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import XCTest
@testable import iAddThree

struct NumberItemPresenter {
    private let item: NumberItem
    
    var userAnswer: String?
    var number: String { "\(item.number)" }
    var isCorrect: Bool { "\(item.answer)" == userAnswer }
    
    init(_ item: NumberItem) {
        self.item = item
    }
}

final class PlayViewDataModel {
    var numberList: [NumberItemPresenter]
    
    private var canSubmitAnswer: Bool { !numberList.filter({ $0.userAnswer == nil }).isEmpty }
    
    init(numberList: [NumberItemPresenter]) {
        self.numberList = numberList
    }
    
    func submitAnswer(_ number: String) {
        guard canSubmitAnswer else { return }
        
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            numberList[index].userAnswer = number
        }
    }
}

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
}


// MARK: - SUT
extension PlayViewDataModelTests {
    func makeSUT(numberList: [NumberItemPresenter]? = nil, file: StaticString = #filePath, line: UInt = #line) -> PlayViewDataModel {
        PlayViewDataModel(numberList: numberList ?? makeItemPresenterList())
    }
    
    func makeItemPresenterList() -> [NumberItemPresenter] {
        NumberItem.defaultList.map { NumberItemPresenter($0) }
    }
}


// MARK: - Helper Extensions
extension NumberItem {
    static var defaultList: [NumberItem] {
        [
            NumberItem(number: 6, answer: 9),
            NumberItem(number: 0, answer: 3),
            NumberItem(number: 2, answer: 5),
            NumberItem(number: 9, answer: 2)
        ]
    }
}
