//
//  SplashScreenToMainNavigationTests.swift
//  MainAppIntegrationTests
//
//  Created by Nikolai Nobadi on 1/24/24.
//

import XCTest
@testable import iAddThree

final class SplashScreenToMainNavigationTests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
}


// MARK: - 
extension SplashScreenToMainNavigationTests {
    func test_splashScreenAppears_adAppears_mainFeaturesAppears_afterClosingAd() throws {
        let app = XCUIApplication()
        app.launchEnvironment["UITesting"] = "true"
        app.launch()
        
        // Wait for Splash Screen to Disappear
        let splashScreen = app.otherElements["SplashView"]
        let splashScreenExists = splashScreen.waitForExistence(timeout: 3)
        XCTAssertFalse(splashScreenExists, "Splash screen should disappear after 3 seconds")
        
        // Verify "Continue to app" button exists
        let continueButton = app.staticTexts["Continue to app"]
        let continueButtonExists = continueButton.waitForExistence(timeout: 3)
        XCTAssertTrue(continueButtonExists, "Continue to app button should exist")
        
        // Tap on the "Continue to app" button
        if continueButtonExists {
            continueButton.tap()
        }
        
        let addButton = app.buttons["Add"]
        XCTAssertTrue(addButton.waitForExistence(timeout: 2), "Add button should exist")
        
        let subtractButton = app.buttons["Subtract"]
        XCTAssertTrue(subtractButton.waitForExistence(timeout: 2), "Subtract button should exist")
        
        let hybridButton = app.buttons["Hybrid"]
        XCTAssertTrue(hybridButton.waitForExistence(timeout: 2), "Hybrid button should exist")
    }
}
