//
//  TestDepenencies.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/26/24.
//

import Foundation

public let UI_USER_DEFAULTS_SUITE = "uiTestingUserDefaults"

public enum TestENVKey: String {
    case requiresAppLaunch, skipSplashScreen, removeAds, unlockedSubtractMode
}
