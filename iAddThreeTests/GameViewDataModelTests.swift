////
////  GameViewDataModelTests.swift
////  iAddThreeTests
////
////  Created by Nikolai Nobadi on 9/24/22.
////
//
//import XCTest
//@testable import iAddThree
//
//final class GameViewDataModelTests: XCTestCase {
//    func test_init_startingValues() {
//        let sut = makeSUT()
//        
//        XCTAssertFalse(sut.timerActive)
//        XCTAssertTrue(sut.numberList.isEmpty)
//        XCTAssertEqual(sut.timeRemaining, 10)
//        XCTAssertNil(sut.results)
//        XCTAssertNil(sut.error)
//        XCTAssertFalse(sut.allAnswersFilled)
//    }
//    
//    func test_startNextLevel_numberListSet() {
//        let sut = makeSUT()
//        
//        sut.startNextLevel()
//        
//        XCTAssertFalse(sut.numberList.isEmpty)
//    }
//    
//    func test_startNextLevel_firstLevel_noTimer() {
//        let sut = makeSUT()
//        
//        sut.startNextLevel()
//        
//        XCTAssertFalse(sut.timerActive)
//    }
//    
//    func test_startNextLevel_secondLevel_timerActive() {
//        let sut = makeSUT(level: 2)
//        
//        sut.startNextLevel()
//        
//        XCTAssertTrue(sut.timerActive)
//    }
//    
//    func test_submitAnswer_numberListEmpty_noSideEffects() {
//        let sut = makeSUT()
//        let answers = ["1", "2", "3", "4"]
//        
//        answers.forEach { sut.submitAnswer($0) }
//        
//        XCTAssertFalse(sut.allAnswersFilled)
//    }
//    
//    func test_submitAnswer_answersFilledFromLeftToRight() {
//        let sut = makeSUT()
//        let answers = ["1", "2", "3", "4"]
//
//        sut.startNextLevel()
//        answers.forEach { sut.submitAnswer($0) }
//        
//        XCTAssertTrue(sut.allAnswersFilled)
//        zip(sut.numberList, answers).forEach { XCTAssertEqual($0.userAnswer, $1) }
//    }
//    
//    func test_submitAnswer_furtherSubmitsHaveNoEffectOnNumberList() {
//        let sut = makeSUT()
//        let answers = ["1", "2", "3", "4"]
//        let moreAnswers = ["5", "6", "7", "8"]
//
//        sut.startNextLevel()
//        answers.forEach { sut.submitAnswer($0) }
//        moreAnswers.forEach { sut.submitAnswer($0) }
//        
//        XCTAssertTrue(sut.allAnswersFilled)
//        zip(sut.numberList, answers).forEach { XCTAssertEqual($0.userAnswer, $1) }
//    }
//    
//    func test_finishLevel_error() async throws {
//        let sut = makeSUT(throwError: true)
//        
//        sut.startNextLevel()
//        
//        let firstNumber = Int(sut.numberList.first!.number)!
//        sut.submitAnswer("\(firstNumber + 3)")
//        
//        sut.finishLevel()
//        
//        try await waitForAsyncMethod(nanoseconds: 0_310_000_000)
//        
//        XCTAssertNotNil(sut.error)
//    }
//    
//    func test_finishLevel_timerWasActive_timerNotActive() async throws {
//        let sut = makeSUT(level: 2)
//        
//        sut.startNextLevel()
//        sut.finishLevel()
//        
//        try await waitForAsyncMethod(nanoseconds: 0_310_000_000)
//        
//        XCTAssertFalse(sut.timerActive)
//    }
//}
//
//
//// MARK: - SUT
//extension GameViewDataModelTests {
//    func makeSUT(mode: GameMode = .add, level: Int = 1, throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> GameViewDataModel {
//        
//        let highScoreStore = MockStore(throwError: throwError)
//        let store = GameStorageManager(store: highScoreStore)
//        let sut = GameViewDataModel(mode: mode, store: store)
//        
//        store.level = level
//        
//        trackForMemoryLeaks(sut, file: file, line: line)
//        
//        return sut
//    }
//    
//    func makeAnsweredNumberList() -> [NumberItemPresenter] {
//        var list = [NumberItemPresenter(NumberItem(number: 0, answer: 3))]
//        
//        list[0].userAnswer = "3"
//        
//        return list
//    }
//}
//
//
//// MARK: - Helper Classes
//extension GameViewDataModelTests {
//    class MockStore: HighScoreStore {
//        private let throwError: Bool
//        var highScore: Int = 0
//        
//        init(throwError: Bool) {
//            self.throwError = throwError
//        }
//        
//        func saveHighScore(_ newHighScore: Int) async throws {
//            if throwError { throw NSError(domain: "test", code: 0) }
//            highScore = newHighScore
//        }
//        
//        func resetHighScore() async throws {
//            
//        }
//    }
//}
