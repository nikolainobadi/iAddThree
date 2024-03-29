//
//  AppStorageKey.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

enum AppStorageKey {
    static let modeLevel = "MODE_LEVEL"
    static let adsRemoved = "ADS_REMOVED"
    static let initialLaunch = "INITIAL_LAUNCH"
    
    static func totalCompletedLevelsKey(modeId: String) -> String {
        return "\(modeId)_TOTAL_COMPLETED_LEVELS"
    }
}
