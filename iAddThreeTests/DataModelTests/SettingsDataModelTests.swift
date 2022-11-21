//
//  SettingsDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import XCTest
@testable import iAddThree

final class SettingsDataModelTests: XCTestCase {
    func test_init_startingValues() {
        let sut = makeSUT()
        
        XCTAssertFalse(sut.showingAbout)
        XCTAssertEqual(sut.state, .list)
        XCTAssertEqual(sut.title, "Settings")
    }
    
    func test_versionText_noVersionProvided() {
        XCTAssertTrue(makeSUT().versionText.isEmpty)
    }
    
    func test_versionText_withVersionProvided() {
        XCTAssertFalse(makeSUT(versionNumber: "1.0.0").versionText.isEmpty)
    }
    
    func test_show() {
        let sut = makeSUT()
        
        sut.show(.upgrade)
        
        XCTAssertEqual(sut.state, .upgrade)
        
        sut.show(.about)
        
        XCTAssertEqual(sut.state, .about)
        
        sut.show(.list)
        
        XCTAssertEqual(sut.state, .list)
    }
    
    func test_rateApp() {
        let exp = expectation(description: "waiting for rateApp")
        let sut = makeSUT(requestAppReview: { exp.fulfill() })
        
        sut.rateApp()
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension SettingsDataModelTests {
    func makeSUT(versionNumber: String? = nil, requestAppReview: @escaping () -> Void = { }, file: StaticString = #filePath, line: UInt = #line) -> SettingsDataModel {
        
        let sut = SettingsDataModel(versionNumber: versionNumber, requestAppReview: requestAppReview)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return sut
    }
}
