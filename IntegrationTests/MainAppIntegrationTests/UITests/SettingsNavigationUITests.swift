//
//  SettingsNavigationUITests.swift
//  MainAppIntegrationTests
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import XCTest
@testable import iAddThree

final class SettingsNavigationUITests: BaseUITestCase {
    public override func setUpWithError() throws {
        try super.setUpWithError()
        addKeysToEnvironment(keys: [.skipSplashScreen])
    }
}


// MARK: - Tests
extension SettingsNavigationUITests {
    func test_navigationToProUpgrade() throws {
        app.launch()
        app.buttons["gearshape"].tap()
        app.buttons["Remove Ads"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Back"]/*[[".buttons[\"Back\"].staticTexts[\"Back\"]",".staticTexts[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Close"].tap()
    }
    
    func test_navigationToOtherSettingsOptions() throws {
        app.launch()
        app.buttons["gearshape"].tap()
        app.buttons["About"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Back"]/*[[".buttons[\"Back\"].staticTexts[\"Back\"]",".staticTexts[\"Back\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.buttons["Rate App"].tap()
    
        waitForElement(app.scrollViews.otherElements.buttons, named: "Not Now").tap()
        
        app.buttons["Close"].tap()
    }
}
