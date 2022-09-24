//
//  XCTestCase+Extensions.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
    
    func waitForAsyncMethod() async throws {
        try await Task.sleep(nanoseconds: 0_010_000_000)
    }
}

