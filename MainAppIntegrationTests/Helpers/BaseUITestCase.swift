//
//  BaseUITestCase.swift
//  MainAppIntegrationTests
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import XCTest

class BaseUITestCase: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchEnvironment["UITesting"] = "true"
    }
}


// MARK: - Helper Methods
extension BaseUITestCase {
    func launchApp(with variables: [String: String] = [:]) {
        for (key, value) in variables {
            app.launchEnvironment[key] = value
        }
        
        app.launch()
    }
    
    func waitForElement(_ query: XCUIElementQuery, named name: String, timeout: TimeInterval = 3, file: StaticString = #filePath, line: UInt = #line) -> XCUIElement {
        let element = query[name]
        
        elementAppeared(query, named: name, timeout: timeout, file: file, line: line)
        
        return element
    }
    
    func elementAppeared(_ query: XCUIElementQuery, named name: String, timeout: TimeInterval = 3, file: StaticString = #filePath, line: UInt = #line) {
        let element = query[name]
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        
        XCTAssertTrue(result == .completed, "\(name) should appear withing \(timeout) seconds", file: file, line: line)
    }
    
    func elementDisappeared(_ query: XCUIElementQuery, named name: String, timeout: TimeInterval = 3, file: StaticString = #filePath, line: UInt = #line) {
        let element = query[name]
        let elementExists = element.waitForExistence(timeout: timeout)
        
        XCTAssertFalse(elementExists, "\(name) should disappear after 3 seconds")
    }
}
