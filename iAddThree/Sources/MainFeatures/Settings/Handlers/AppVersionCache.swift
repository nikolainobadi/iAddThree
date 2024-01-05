//
//  AppVersionCache.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation

enum AppVersionCache {
    static func getVersionDetails() -> String {
        guard let versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String else { return "" }
        
        let versionString = "Version \(versionNumber)"
        
        #if DEBUG
        guard let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String else { return versionString }
        
        return "\(versionString), Build: \(buildNumber)"
        #else
        return versionString
        #endif
    }
}
