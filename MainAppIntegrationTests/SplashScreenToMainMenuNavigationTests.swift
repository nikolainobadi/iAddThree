//
//  SplashScreenToMainNavigationTests.swift
//  MainAppIntegrationTests
//
//  Created by Nikolai Nobadi on 1/24/24.
//

import XCTest
@testable import iAddThree

final class SplashScreenToMainMenuNavigationTests: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchEnvironment["UITesting"] = "true"
    }
}


// MARK: - 
extension SplashScreenToMainMenuNavigationTests {
    func test_splashScreenAppears_adAppears_mainFeaturesAppears_afterClosingAd() throws {
        launchApp()
        
        let splashScreen = app.otherElements["SplashView"]
        let splashScreenExists = splashScreen.waitForExistence(timeout: 3)
        XCTAssertFalse(splashScreenExists, "Splash screen should disappear after 3 seconds")
        
        let continueButton = app.staticTexts["Continue to app"]
        let continueButtonExists = continueButton.waitForExistence(timeout: 3)
        XCTAssertTrue(continueButtonExists, "Continue to app button should exist")
        
        if continueButtonExists {
            continueButton.tap()
        }
        
        ["Add", "Subtract", "Hybrid"].forEach {
            XCTAssertTrue(app.buttons[$0].waitForExistence(timeout: 2), "\($0) button should exist")
        }
    }
    
    func test_proUsers_splashScreenAppears_noAdsShown_mainFeaturesAppears() throws {
        launchApp(with: ["RemoveAds": "true"])
        
        let splashScreen = app.otherElements["SplashView"]
        let splashScreenExists = splashScreen.waitForExistence(timeout: 3)
        XCTAssertFalse(splashScreenExists, "Splash screen should disappear after 3 seconds")
        
        ["Add", "Subtract", "Hybrid"].forEach {
            XCTAssertTrue(app.buttons[$0].waitForExistence(timeout: 2), "\($0) button should exist")
        }
    }
}


// MARK: - Helper Methods
private extension SplashScreenToMainMenuNavigationTests {
    func launchApp(with variables: [String: String] = [:]) {
        for (key, value) in variables {
            app.launchEnvironment[key] = value
        }
        
        app.launch()
    }
    
    func waitForElementToAppear(_ element: XCUIElement, timeout: TimeInterval = 3) -> Bool {
        let existsPredicate = NSPredicate(format: "exists == TRUE")
        let expectation = XCTNSPredicateExpectation(predicate: existsPredicate, object: element)
        let result = XCTWaiter.wait(for: [expectation], timeout: timeout)
        return result == .completed
    }
}
