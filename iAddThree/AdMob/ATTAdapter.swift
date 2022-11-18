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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            ATTrackingManager.requestTrackingAuthorization { status in
                GADMobileAds.sharedInstance().start()
            }
        }
    }
}
