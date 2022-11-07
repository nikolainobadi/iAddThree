//
//  InstructionsDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import XCTest
@testable import iAddThree

final class InstructionsDataModelTests: XCTestCase {
    func test_init_currentPageZero() {
        XCTAssertEqual(makeSUT().currentPage, 0)
    }
    
    func test_modeTitle() {
        XCTAssertEqual(makeSUT().modeTitle, GameMode.add.title)
    }
    
    func test_sampleList_count() {
        XCTAssertEqual(makeSUT().sampleList.count, 4)
    }
    
    func test_turnPage_cannotTurnBackwardsPassedFirstPage() {
        let sut = makeSUT()
        
        sut.turnPage(backwards: true)
        
        XCTAssertEqual(sut.currentPage, 0)
    }
    
    func test_turnPage_cannotExceedPageLimit() {
        let mode = GameMode.add
        let pageCount = mode.instructionsList.count
        let sut = makeSUT(mode: mode)
        
        var count = 0
        
        while count < pageCount + 1 {
            sut.turnPage(backwards: false)
            count += 1
        }
        
        XCTAssertEqual(sut.currentPage, pageCount - 1)
    }
    
    func test_showHowToTitle() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.showHowToTitle)
        
        sut.turnPage(backwards: false)
        
        XCTAssertFalse(sut.showHowToTitle)
        
        sut.turnPage(backwards: true)
        
        XCTAssertTrue(sut.showHowToTitle)
    }
    
    func test_showPreviousButton() {
        let sut = makeSUT()
        
        XCTAssertFalse(sut.showPreviousButton)
        
        sut.turnPage(backwards: false)
        
        XCTAssertTrue(sut.showPreviousButton)
        
        sut.turnPage(backwards: false)
        
        XCTAssertTrue(sut.showPreviousButton)
        
        sut.turnPage(backwards: true)
        
        XCTAssertTrue(sut.showPreviousButton)
        
        sut.turnPage(backwards: true)
        
        XCTAssertFalse(sut.showPreviousButton)
    }
    
    func test_showNextButton() {
        let sut = makeSUT()
        
        XCTAssertTrue(sut.showNextButton)
        
        sut.turnPage(backwards: false)
        
        XCTAssertTrue(sut.showNextButton)
        
        sut.turnPage(backwards: false)
        
        XCTAssertFalse(sut.showNextButton)
        
        sut.turnPage(backwards: true)
        
        XCTAssertTrue(sut.showNextButton)
        
        sut.turnPage(backwards: true)
        
        XCTAssertTrue(sut.showNextButton)
    }
    
    func test_instructions() {
        let mode = GameMode.add
        let instructionsList = mode.instructionsList
        let sut = makeSUT(mode: mode)
        
        XCTAssertEqual(sut.instructions, instructionsList[0].details)
        
        sut.turnPage(backwards: false)
        
        XCTAssertEqual(sut.instructions, instructionsList[1].details)
        
        sut.turnPage(backwards: false)
        
        XCTAssertEqual(sut.instructions, instructionsList[2].details)
        
        sut.turnPage(backwards: true)
        
        XCTAssertEqual(sut.instructions, instructionsList[1].details)
        
        sut.turnPage(backwards: true)
        
        XCTAssertEqual(sut.instructions, instructionsList[0].details)
    }
}


// MARK: - SUT
extension InstructionsDataModelTests {
    func makeSUT(mode: GameMode = .add, file: StaticString = #filePath, line: UInt = #line) -> InstructionsDataModel {
        
        InstructionsDataModel(mode: mode)
    }
}
