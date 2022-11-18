//
//  AdMobId.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

enum AdMobId: String {
    case banner = "ca-app-pub-1506379315609688/8599392631"
    case interstitial = "ca-app-pub-1506379315609688/5817222948"
    
    var testId: String {
        switch self {
        case .banner: return "ca-app-pub-3940256099942544/2934735716"
        case .interstitial: return "ca-app-pub-3940256099942544/4411468910"
        }
    }
}
