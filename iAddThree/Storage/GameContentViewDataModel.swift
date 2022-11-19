//
//  GameContentViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import Foundation

final class GameContentViewDataModel: ObservableObject {
    var score = 0
    var level = 1
}

extension GameContentViewDataModel: LevelScoreStore {
    func updateLevel(_ newLevel: Int) { level = newLevel }
    func updateScore(_ newScore: Int) { score = newScore }
}
