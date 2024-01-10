//
//  GameViewModelTests.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import XCTest
@testable import iAddThreeCore

final class GameViewModelTests: XCTestCase {
    func test_init_startingValues() {
        XCTAssertNil(makeSUT().selectedMode)
    }
    
    func test_playSelectedMode_addMode_selectedModeIsSet_toAdd() throws {
        for modeLevel in 0...2 {
            let sut = makeSUT(modeLevel: modeLevel)
            
            try sut.playSelectedMode(.add)
            
            XCTAssertEqual(sut.selectedMode, .add, "Failed at modeLevel: \(modeLevel)")
        }
    }
    
    func test_playSelectedMode_subtractMode_whenModeLevel_isTooLow_throwsSubtractError() {
        let sut = makeSUT(modeLevel: 0)

        XCTAssertThrowsError(try sut.playSelectedMode(.subtract)) { error in
            XCTAssertEqual(error as? ModeLevelError, .subtract)
        }
    }

    func test_playSelectedMode_subtractMode_selectedModeIsSet_toSubtract() throws {
        for modeLevel in 1...2 {
            let sut = makeSUT(modeLevel: modeLevel)
            
            try sut.playSelectedMode(.subtract)
            
            XCTAssertEqual(sut.selectedMode, .subtract, "Failed at modeLevel: \(modeLevel)")
        }
    }
    
    func test_playSelectedMode_hybridMode_whenModeLevel_isTooLow_throwsHybridError() {
        for modeLevel in 0...1 {
            let sut = makeSUT(modeLevel: modeLevel)

            XCTAssertThrowsError(try sut.playSelectedMode(.hybrid)) { error in
                XCTAssertEqual(error as? ModeLevelError, .hybrid, "Failed at modeLevel: \(modeLevel)")
            }
        }
    }
    
    func test_playSelectedMode_hybridMode_selectedModeIsSet_toHybrid() throws {
        let sut = makeSUT(modeLevel: 2)

        try sut.playSelectedMode(.hybrid)

        XCTAssertEqual(sut.selectedMode, .hybrid)
    }
}


// MARK: - SUT
extension GameViewModelTests {
    func makeSUT(modeLevel: Int = 0) -> MainFeaturesViewModel {
        return MainFeaturesViewModel(store: MockStore(modeLevel: modeLevel))
    }
}


// MARK: - Helper Classes
extension GameViewModelTests {
    class MockStore: GameModeStore {
        let modeLevel: Int
        
        init(modeLevel: Int) {
            self.modeLevel = modeLevel
        }
    }
}
