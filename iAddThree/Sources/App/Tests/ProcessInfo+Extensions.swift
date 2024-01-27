//
//  ProcessInfo+Extensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import Foundation
import iAddThreeClassicKit



extension ProcessInfo {
    static var isTesting: Bool {
        return isTrue(.requiresAppLaunch) || NSClassFromString("XCTestCase") != nil
    }
    
    static func isTrue(_ key: TestENVKey) -> Bool {
        return processInfo.environment[key.rawValue] == "true"
    }
}

extension UserDefaults {
    static func customInit() -> UserDefaults {
        if ProcessInfo.isTesting {
            print("testeing defaults")
            return .testingSuite()
        }
        
        print("standard")
        
        return .standard
    }
    
    static func testingSuite(name: String? = nil) -> UserDefaults {
        return .init(suiteName: name ?? UI_USER_DEFAULTS_SUITE) ?? .standard
    }
}
