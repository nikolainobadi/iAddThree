//
//  ATTAdapter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/17/22.
//

import Foundation
import GoogleMobileAds
import AppTrackingTransparency

enum ATTAdapter {
    static func initializeAdService() {
        ATTrackingManager.requestTrackingAuthorization { status in
            GADMobileAds.sharedInstance().start()
        }
    }
}
