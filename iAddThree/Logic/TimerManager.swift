//
//  TimerManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/25/22.
//

import Foundation

enum TimerManager {
    static func makeStartTime(for level: Int) -> Float {
        switch level {
        case 1: return 0
        case 2...10: return 10 - (0.5 * (Float(level) - 2))
        case 11...20: return 6 - (0.2 * (Float(level) - 10))
        case 21...30: return 4 - (0.1 * (Float(level) - 20))
        default: return -1 // end of game
        }
    }
}
