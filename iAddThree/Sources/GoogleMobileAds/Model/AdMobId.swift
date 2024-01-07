//
//  AdMobId.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

enum AdMobId: String {
    case interstitial, openApp
    
    var unitId: String {
        #if DEBUG
        return testId
        #else
        return releaseId
        #endif
    }
}


// MARK: - Private
private extension AdMobId {
    var testId: String {
        switch self {
        case .interstitial:
            return "ca-app-pub-3940256099942544/4411468910"
        case .openApp:
            return "ca-app-pub-3940256099942544/5575463023"
        }
    }
    
    var releaseId: String {
        switch self {
        case .interstitial:
            return "ca-app-pub-6607027445077729/1937777281"
        case .openApp:
            return "ca-app-pub-6607027445077729/6340056726"
        }
    }
}
