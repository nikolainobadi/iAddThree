//
//  ContentViewDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import XCTest
import Combine
@testable import iAddThree

final class ContentViewDataModelTests: XCTestCase {
    private var changes = Set<AnyCancellable>()
    
    override func tearDown() {
        super.tearDown()
        
        changes.removeAll()
        XCTAssertTrue(changes.isEmpty)
    }
    
    func test_init_startingValues() {
        XCTAssertFalse(makeSUT().sut.removeAds)
    }
    
    func test_removeAdsPublisher() {
        let exp = expectation(description: "waiting for publisher")
        let (sut, publisher) = makeSUT()
        
        sut.$removeAds
            .dropFirst()
            .sink { XCTAssertTrue($0); exp.fulfill() }
            .store(in: &changes)
        
        publisher.removeAds = true
        
        waitForExpectations(timeout: 0.1)
    }
}


// MARK: - SUT
extension ContentViewDataModelTests {
    func makeSUT(file: StaticString = #filePath, line: UInt = #line) -> (sut: ContentViewDataModel, publisher: MockPublisher) {
        let publisher = MockPublisher()
        let sut = ContentViewDataModel(publisher: publisher)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, publisher)
    }
}


// MARK: - Helper Classes
extension ContentViewDataModelTests {
    class MockPublisher: ProStatusPublisher {
        @Published var removeAds = false
        
        var removeAdsPublisher: Published<Bool>.Publisher { $removeAds }
    }
}
