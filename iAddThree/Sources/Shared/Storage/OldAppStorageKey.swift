//
//  AppStorageKey.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

enum OldAppStorageKey {
    static let modeLevel = "MODE_LEVEL"
    static let adsRemoved = "ADS_REMOVED"
    static let initialLaunch = "INITIAL_LAUNCH"
    
    static func totalCompletedLevelsKey(modeId: String) -> String {
        return "\(modeId)_TOTAL_COMPLETED_LEVELS"
    }
}

enum AppStorageKey {
    typealias ModeId = String
    
    case totalLevelsCompleted(ModeId)
    case modeLevel, adsRemoved, initialLaunch
    
    var key: String {
        switch self {
        case .modeLevel:
            return "MODE_LEVEL"
        case .adsRemoved:
            return "ADS_REMOVED"
        case .initialLaunch:
            return "INITIAL_LAUNCH"
        case .totalLevelsCompleted(let modeId):
            return "\(modeId)_TOTAL_COMPLETED_LEVELS"
        }
    }
}
