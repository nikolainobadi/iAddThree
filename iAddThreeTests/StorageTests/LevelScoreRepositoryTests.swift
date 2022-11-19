//
//  LevelScoreRepositoryTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/4/22.
//

import XCTest
@testable import iAddThree

final class LevelScoreRepositoryTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let sut = makeSUT()
        
        XCTAssertEqual(sut.score, 0)
        XCTAssertEqual(sut.level, 1)
    }
    
    func test_updateLevel() {
        let newLevel = 2
        let sut = makeSUT()
        
        sut.updateLevel(newLevel)
        
        XCTAssertEqual(sut.level, newLevel)
    }
    
    func test_updateScore() {
        let newScore = 4
        let sut = makeSUT()
        
        sut.updateScore(newScore)
        
        XCTAssertEqual(sut.score, newScore)
    }
}


// MARK: - SUT
extension LevelScoreRepositoryTests {
    func makeSUT() -> GameContentViewDataModel {
        GameContentViewDataModel()
    }
}
