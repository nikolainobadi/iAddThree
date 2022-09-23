//
//  NumberItemFactoryTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import XCTest
@testable import iAddThree

final class NumberItemFactoryTests: XCTestCase {
    func test_makeNumberList_addMode_arrayReturnedNotEmpty() {
        XCTAssertFalse(NumberItemFactory.makeNumberList(.add).isEmpty)
    }
    
    func test_makeNumberList_addMode_returnsCorrectNumberOfItems() {
        XCTAssertEqual(NumberItemFactory.makeNumberList(.add).count, 4)
    }
    
    func test_makeNumberList_addMode_answersAreNumberPlus3() {
        let list = maketWithNumbersLessThan7()
        
        XCTAssertTrue(list.contains(where: { $0.number < 7 }))
        
        list.forEach {
            if $0.number < 7 {
                XCTAssertEqual($0.answer, $0.number + 3)
            }
        }
    }
    
    func test_makeNumberList_addMode_doubleDigitAnswersOnlyHaveSecondDigit() {
        let list = makeNumberListWithNumbersGreaterThan6()
        
        XCTAssertTrue(list.contains(where: { $0.number > 6 }))
        
        list.forEach {
            if $0.number > 6 {
                XCTAssertEqual($0.answer, ($0.number + 3) - 10)
            }
        }
    }
}


// MARK: - Test Helpers
private extension NumberItemFactoryTests {
    func maketWithNumbersLessThan7(mode: GameMode = .add) -> [NumberItem] {
        let list = NumberItemFactory.makeNumberList(mode)
        
        if list.contains(where: { $0.number < 7 }) {
            return list
        } else {
            return maketWithNumbersLessThan7()
        }
    }
    
    func makeNumberListWithNumbersGreaterThan6(mode: GameMode = .add) -> [NumberItem] {
        let list = NumberItemFactory.makeNumberList(mode)
        
        if list.contains(where: { $0.number > 6 }) {
            return list
        } else {
            return makeNumberListWithNumbersGreaterThan6()
        }
    }
}
