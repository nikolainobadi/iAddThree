//
//  ProcessInfo+Extensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import Foundation

extension ProcessInfo {
    static var isTesting: Bool {
        return requiresAppLaunch || NSClassFromString("XCTestCase") != nil
    }
    
    static var requiresAppLaunch: Bool {
        return processInfo.environment["UITesting"] == "true"
    }
}

extension UserDefaults {
    static func testingSuite(name: String? = nil) -> UserDefaults {
        return .init(suiteName: name ?? "uiTestingUserDefaults") ?? .standard
    }
}
