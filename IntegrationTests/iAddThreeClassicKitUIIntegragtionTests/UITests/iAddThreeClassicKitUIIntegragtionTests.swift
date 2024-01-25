//
//  iAddThreeClassicKitUIIntegragtionTests.swift
//  iAddThreeClassicKitUIIntegragtionTests
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import XCTest
import iAddThreeClassicKit

final class iAddThreeClassicKitUIIntegragtionTests: BaseUITestCase {
    func test_allIncorrectAnswers_requiresLevel_toBeRepeated() throws {
        launchApp(with: [CLASSIC_KIT_TESTING: "true", "SkipSplashScreen": "true"])
        
        app.buttons["Start Game"].tap()
        
        let button = app.buttons["3"]
        button.tap()
        button.tap()
        button.tap()
        button.tap()
//        app.buttons["Level 2"].tap()
    }
}
