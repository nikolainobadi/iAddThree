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
        
        let button = app.buttons["0"]
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        
        waitForElement(app.buttons, named: "Try Again?", timeout: 5).tap()
        elementAppeared(app.staticTexts, named: "Level: 1")
        elementAppeared(app.staticTexts, named: "Score: 0")
    }
}
