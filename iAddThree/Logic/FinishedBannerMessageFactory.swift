//
//  FinishedBannerMessageFactory.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

enum FinishedBannerMessage: String {
    case noPoints = "Not Quite"
    case one = "Nice Try"
    case two = "Good Job!"
    case three = "Great Job!"
    case four = "Perfect!"
    case timesUp = "Times Up!"
}

enum FinishedBannerMessageFactory {
    static func makeMessage(_ results: LevelResults) -> String {
        guard !results.timerFinished else { return getMessage(.timesUp) }
        
        switch results.pointsToAdd {
        case 1: return getMessage(.one)
        case 2: return getMessage(.two)
        case 3: return getMessage(.three)
        case 4: return getMessage(.four)
        default: return getMessage(.noPoints)
        }
    }
    
    private static func getMessage(_ message: FinishedBannerMessage) -> String { message.rawValue }
}
