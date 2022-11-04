//
//  LevelResult.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import Foundation

struct LevelResult: Equatable {
    let currentScore: Int
    let pointsToAdd: Int
    let currentLevel: Int
    let timerFinished: Bool
}
