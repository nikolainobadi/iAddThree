//
//  GameViewDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import XCTest
@testable import iAddThree

final class GameViewDataModelTests: XCTestCase {
    
    
}


// MARK: - SUT
extension GameViewDataModelTests {
    func makeSUT(mode: GameMode = .add, results: LevelResultInfo? = nil,file: StaticString = #filePath, line: UInt = #line) -> GameViewDataModel {
        
        let store = MockStore(results: results)
        let sut = GameViewDataModel(mode: mode, store: store)
        
        return sut
    }
}


// MARK: - Helper Classes
extension GameViewDataModelTests {
    class MockStore: GameStore {
        private let results: LevelResultInfo?
        
        var score = 0
        var level = 1
        var highScore = 0
        
        init(results: LevelResultInfo?) {
            self.results = results
        }
        
        func loadResults(pointsToAdd: Int) async throws -> LevelResultInfo {
            if let results = results {
                return results
            } else {
                throw NSError(domain: "test", code: 0)
            }
        }
    }
}
