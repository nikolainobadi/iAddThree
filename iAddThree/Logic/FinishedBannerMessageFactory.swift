//
//  FinishedBannerMessageFactory.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

enum FinishedBannerMessageFactory {
    static func makeMessage(_ results: LevelResults) -> String {
        guard !results.timerFinished else { return "Times Up!" }
        
        switch results.pointsToAdd {
        case 1: return "Nice Try"
        case 2: return "Good Job!"
        case 3: return "Great Job!"
        case 4: return "Perfect!"
        default: return "Not Quite"
        }
    }
}
