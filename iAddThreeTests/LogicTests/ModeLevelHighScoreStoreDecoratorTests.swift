//
//  ModeLevelHighScoreStoreDecoratorTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/17/22.
//

import XCTest
@testable import iAddThree

final class ModeLevelHighScoreStoreDecoratorTests: XCTestCase {
    
    
}


// MARK: - SUT
extension ModeLevelHighScoreStoreDecoratorTests {
    func makeSUT(mode: GameMode = .add, file: StaticString = #filePath, line: UInt = #line) -> (sut: HighScoreStore, store: HighScoreStore) {
        
        let defaults = makeUserDefaults()
        let store = SinglePlayHighScoreStore()
        let sut = ModeLevelHighScoreStoreDecorator(mode: mode, decoratee: store, defaults: defaults)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
    
    func makeUserDefaults() -> UserDefaults {
        let defaults = UserDefaults(suiteName: #file)!
        defaults.removePersistentDomain(forName: #file)
        return defaults
    }
}
