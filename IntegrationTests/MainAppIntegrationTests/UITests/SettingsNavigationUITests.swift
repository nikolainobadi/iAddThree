//
//  SettingsNavigationUITests.swift
//  MainAppIntegrationTests
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import XCTest
@testable import iAddThree

final class SettingsNavigationUITests: BaseUITestCase {
    func test_navigationToProUpgrade() throws {
        launchApp(with: ["SkipSplashScreen": "true"])
        
        app.buttons["gearshape"].tap()
        app.buttons["Remove Ads"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Back"]/*[[".buttons[\"Back\"].staticTexts[\"Back\"]",".staticTexts[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
    }
    
    func test_navigationToOtherSettingsOptions() throws {
        launchApp(with: ["SkipSplashScreen": "true"])
                
        app.buttons["gearshape"].tap()
        app.buttons["About"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Back"]/*[[".buttons[\"Back\"].staticTexts[\"Back\"]",".staticTexts[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Rate App"].tap()
    
        waitForElement(app.scrollViews.otherElements.buttons, named: "Not Now").tap()
        
        app.buttons["Close"].tap()
    }
}
