//
//  LevelResultInfo.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import Foundation

struct LevelResultInfo: Equatable {
    let currentScore: Int
    let pointsToAdd: Int
    let currentLevel: Int
    let timerFinished: Bool
}
