//
//  iAddThreeClassicKitUIIntegragtionTests.swift
//  iAddThreeClassicKitUIIntegragtionTests
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import XCTest
import iAddThreeCore
import iAddThreeClassicKit

final class iAddThreeClassicKitUIIntegragtionTests: BaseUITestCase {
    public override func setUpWithError() throws {
        try super.setUpWithError()
        addKeysToEnvironment(keys: [.skipSplashScreen])
        app.launchEnvironment[CLASSIC_KIT_TESTING] = "true"
    }
}


// MARK: - Add Mode Tests
extension iAddThreeClassicKitUIIntegragtionTests {
    func test_inAddMode_passingFirstLevel_unlocksSubtractMode() throws {
        launchAndStartMode(.add)
        
        // play the game
        let button = app.buttons["0"]
        button.tap()
        button.tap()
        button.tap()
        app.buttons["3"].tap()
        
        // start next level
        waitForElement(app.buttons, named: "Level 2", timeout: 5).tap()
        elementAppeared(app.staticTexts, named: "Level: 2")
        elementAppeared(app.staticTexts, named: "Score: 1")
        
        // navigate back to main menu
        app/*@START_MENU_TOKEN@*/.staticTexts["  "]/*[[".buttons[\"  \"].staticTexts[\"  \"]",".staticTexts[\"  \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Menu"]/*[[".buttons[\"Menu\"].staticTexts[\"Menu\"]",".staticTexts[\"Menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // start subract mode
        app.buttons["Subtract"].tap()
        app.buttons["Start Game"].tap()
        
        // verify starting values
        elementAppeared(app.staticTexts, named: "Level: 1")
        elementAppeared(app.staticTexts, named: "Score: 0")
    }
    
    func test_allIncorrectAnswers_requiresLevel_toBeRepeated() throws {
        launchAndStartMode(.add)
        
        // play the game, no correct answers
        let button = app.buttons["0"]
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        
        
        // try the same level again
        waitForElement(app.buttons, named: "Try Again?", timeout: 5).tap()
        elementAppeared(app.staticTexts, named: "Level: 1")
        elementAppeared(app.staticTexts, named: "Score: 0")
        
        // navigate back to main menu
        app/*@START_MENU_TOKEN@*/.staticTexts["  "]/*[[".buttons[\"  \"].staticTexts[\"  \"]",".staticTexts[\"  \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Menu"]/*[[".buttons[\"Menu\"].staticTexts[\"Menu\"]",".staticTexts[\"Menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // try to start subract mode
        app.buttons["Subtract"].tap()
        app.alerts["Restricted"].scrollViews.otherElements.buttons["Ok"].tap()
    }
}

 
// MARK: - Subtract Mode Tests
extension iAddThreeClassicKitUIIntegragtionTests {
    func test_passingFirstLevel_doesNotUnlockHybridMode() {
        addKeysToEnvironment(keys: [.unlockedSubtractMode])
        launchAndStartMode(.subtract)
        
        // play the game
        let button = app.buttons["7"]
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        
        // start the next level
        waitForElement(app.buttons, named: "Level 2", timeout: 5).tap()
        
        // navigate back to main menu
        app.staticTexts["  "].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Menu"]/*[[".buttons[\"Menu\"].staticTexts[\"Menu\"]",".staticTexts[\"Menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // try to start subract mode
        app.buttons["Hybrid"].tap()
        app.alerts["Restricted"].scrollViews.otherElements.buttons["Ok"].tap()
    }
    
    func test_passingCorrectLevel_unlocksHybridMode() throws {
        addClassicKey(.level, value: "10")
        addClassicKey(.score, value: "10")
        addKeysToEnvironment(keys: [.unlockedSubtractMode])
        launchAndStartMode(.subtract, startText: "Level 10")
        
        // play the game
        let button = app.buttons["7"]
        button.tap()
        button.tap()
        button.tap()
        button.tap()
        
        // start next level
        waitForElement(app.buttons, named: "Level 11", timeout: 5).tap()
        
        // navigate back to main menu
        app/*@START_MENU_TOKEN@*/.staticTexts["  "]/*[[".buttons[\"  \"].staticTexts[\"  \"]",".staticTexts[\"  \"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Menu"]/*[[".buttons[\"Menu\"].staticTexts[\"Menu\"]",".staticTexts[\"Menu\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        // start hybrid mode
        app.buttons["Hybrid"].tap()
        app.buttons["How to Play"].tap()
    }
}


// MARK: - Helper Methods
extension iAddThreeClassicKitUIIntegragtionTests {
    func addClassicKey(_ key: TestDataKey, value: String) {
        app.launchEnvironment[key.rawValue] = value
    }
    
    func launchAndStartMode(_ mode: GameMode, startText: String = "Start Game") {
        app.launch()
        app.buttons[mode.name].tap()
        app.buttons[startText].tap()
    }
}
