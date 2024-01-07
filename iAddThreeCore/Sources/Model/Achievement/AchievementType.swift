//
//  AchievementType.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import Foundation

enum AchievementType {
    case level(Int)
    case time(TimeInterval)
    case playCount(Int)
    case perfectScoreStreak(Int)
}

