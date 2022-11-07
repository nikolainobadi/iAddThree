//
//  TimerManagerTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/25/22.
//

import XCTest
@testable import iAddThree

final class TimerManagerTests: XCTestCase {
    func test_makeStartTime_level1() {
        XCTAssertEqual(TimerManager.makeStartTime(for: 1), 0)
    }
    
    func test_makeStartTime_firstTierLevels() {
        XCTAssertEqual(TimerManager.makeStartTime(for: 2), 10)
        XCTAssertEqual(TimerManager.makeStartTime(for: 3), 9.5)
        XCTAssertEqual(TimerManager.makeStartTime(for: 4), 9)
        XCTAssertEqual(TimerManager.makeStartTime(for: 5), 8.5)
        XCTAssertEqual(TimerManager.makeStartTime(for: 6), 8)
        XCTAssertEqual(TimerManager.makeStartTime(for: 7), 7.5)
        XCTAssertEqual(TimerManager.makeStartTime(for: 8), 7)
        XCTAssertEqual(TimerManager.makeStartTime(for: 9), 6.5)
        XCTAssertEqual(TimerManager.makeStartTime(for: 10), 6)
    }
    
    func test_makeStartTime_secondTierLevels() {
        XCTAssertEqual(TimerManager.makeStartTime(for: 11), 5.8)
        XCTAssertEqual(TimerManager.makeStartTime(for: 12), 5.6)
        XCTAssertEqual(TimerManager.makeStartTime(for: 13), 5.4)
        XCTAssertEqual(TimerManager.makeStartTime(for: 14), 5.2)
        XCTAssertEqual(TimerManager.makeStartTime(for: 15), 5)
        XCTAssertEqual(TimerManager.makeStartTime(for: 16), 4.8)
        XCTAssertEqual(TimerManager.makeStartTime(for: 17), 4.6)
        XCTAssertEqual(TimerManager.makeStartTime(for: 18), 4.4)
        XCTAssertEqual(TimerManager.makeStartTime(for: 19), 4.2)
        XCTAssertEqual(TimerManager.makeStartTime(for: 20), 4)
    }
    
    func test_makeStartTime_thirdTierLevels() {
        XCTAssertEqual(TimerManager.makeStartTime(for: 21), 3.9)
        XCTAssertEqual(TimerManager.makeStartTime(for: 22), 3.8)
        XCTAssertEqual(TimerManager.makeStartTime(for: 23), 3.7)
        XCTAssertEqual(TimerManager.makeStartTime(for: 24), 3.6)
        XCTAssertEqual(TimerManager.makeStartTime(for: 25), 3.5)
        XCTAssertEqual(TimerManager.makeStartTime(for: 26), 3.4)
        XCTAssertEqual(TimerManager.makeStartTime(for: 27), 3.3)
        XCTAssertEqual(TimerManager.makeStartTime(for: 28), 3.2)
        XCTAssertEqual(TimerManager.makeStartTime(for: 29), 3.1)
        XCTAssertEqual(TimerManager.makeStartTime(for: 30), 3)
    }
}
