//
//  CanShowAdsKey.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI

struct CanShowAdsKey: EnvironmentKey {
    static let defaultValue: Bool = false // Default value
}

public extension EnvironmentValues {
    var canShowAds: Bool {
        get { self[CanShowAdsKey.self] }
        set { self[CanShowAdsKey.self] = newValue }
    }
}
