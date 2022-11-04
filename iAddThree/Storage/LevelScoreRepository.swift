//
//  LevelScoreRepository.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import Foundation

final class LevelScoreRepository: ObservableObject {
    var score = 0
    var level = 1
}

extension LevelScoreRepository: LevelScoreStore {
    func updateLevel(_ newLevel: Int) { level = newLevel }
    func updateScore(_ newScore: Int) { score = newScore }
}

protocol LevelScoreStore {
    var score: Int { get }
    var level: Int { get }
    
    func updateLevel(_ newLevel: Int)
    func updateScore(_ newScore: Int)
}
