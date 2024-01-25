//
//  SplashScreenToMainNavigationTests.swift
//  MainAppIntegrationTests
//
//  Created by Nikolai Nobadi on 1/24/24.
//

import XCTest
@testable import iAddThree

final class SplashScreenToMainMenuNavigationTests: BaseUITestCase {
    func test_splashScreenAppears_adAppears_mainFeaturesAppears_afterClosingAd() throws {
        launchApp()
        elementDisappeared(app.otherElements, named: "SplashView")
        waitForElement(app.staticTexts, named: "Continue to app").tap()
        menuButtonsDidAppear()
    }
    
    func test_proUsers_splashScreenAppears_noAdsShown_mainFeaturesAppears() throws {
        launchApp(with: ["RemoveAds": "true"])
        elementDisappeared(app.otherElements, named: "SplashView")
        menuButtonsDidAppear()
    }
}


// MARK: - Private Methods
private extension SplashScreenToMainMenuNavigationTests {
    func menuButtonsDidAppear(file: StaticString = #filePath, line: UInt = #line) {
        ["Add", "Subtract", "Hybrid"].forEach {
            elementAppeared(app.buttons, named: $0, timeout: 1.5, file: file, line: line)
        }
    }
}
