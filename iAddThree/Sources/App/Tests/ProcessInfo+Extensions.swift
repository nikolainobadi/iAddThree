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
        return requiresAppLaunch || NSClassFromString("XCTestCase") != nil
    }
    
    static var requiresAppLaunch: Bool {
        return processInfo.environment["UITesting"] == "true"
    }
    
    static var removeAds: Bool {
        return processInfo.environment["RemoveAds"] == "true"
    }
    
    static var skipSplashScreen: Bool {
        return processInfo.environment["SkipSplashScreen"] == "true"
    }
    
    static var isTestingClassicKit: Bool {
        return processInfo.environment[CLASSIC_KIT_TESTING] == "true"
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
        return .init(suiteName: name ?? "uiTestingUserDefaults") ?? .standard
    }
}
