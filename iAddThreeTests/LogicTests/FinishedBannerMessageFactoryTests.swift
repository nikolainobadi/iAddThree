//
//  FinishedBannerMessageFactoryTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import XCTest
@testable import iAddThree

final class FinishedBannerMessageFactoryTests: XCTestCase {
    func test_makeMessage_noPoints() {
        XCTAssertEqual(FinishedBannerMessageFactory.makeMessage(makeResults()), getMessage(.noPoints))
    }
    
    func test_makeMessage_onePoint() {
        XCTAssertEqual(FinishedBannerMessageFactory.makeMessage(makeResults(pointsToAdd: 1)), getMessage(.one))
    }
    
    func test_makeMessage_twoPoints() {
        XCTAssertEqual(FinishedBannerMessageFactory.makeMessage(makeResults(pointsToAdd: 2)), getMessage(.two))
    }
    
    func test_makeMessage_threePoints() {
        XCTAssertEqual(FinishedBannerMessageFactory.makeMessage(makeResults(pointsToAdd: 3)), getMessage(.three))
    }
    
    func test_makeMessage_fourPoints() {
        XCTAssertEqual(FinishedBannerMessageFactory.makeMessage(makeResults(pointsToAdd: 4)), getMessage(.four))
    }
    
    func test_makeMessage_timerFinished() {
        XCTAssertEqual(FinishedBannerMessageFactory.makeMessage(makeResults(timerFinished: true)), getMessage(.timesUp))
    }
}


// MARK: - Helpers
extension FinishedBannerMessageFactoryTests {
    func getMessage(_ message: FinishedBannerMessage) -> String { message.rawValue }
    func makeResults(pointsToAdd: Int = 0, timerFinished: Bool = false) -> LevelResults {
        LevelResults(currentScore: 0, pointsToAdd: pointsToAdd, currentLevel: 1, timerFinished: timerFinished)
    }
}
