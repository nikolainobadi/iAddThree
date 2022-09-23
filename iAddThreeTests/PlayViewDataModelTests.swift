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
    
    init(numberList: [NumberItemPresenter]) {
        self.numberList = numberList
    }
}

final class PlayViewDataModelTests: XCTestCase {
    func test_init_numberListFilled() {
        XCTAssertFalse(makeSUT().numberList.isEmpty)
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
