//
//  SharedGoogleAdManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation
import GoogleMobileAds
import AppTrackingTransparency

enum SharedGoogleAdManager {
    static var didSetAuthStatus: Bool {
        return appTrackingAuthStatus != .notDetermined
    }
    
    static var appTrackingAuthStatus: ATTrackingManager.AuthorizationStatus {
        return ATTrackingManager.trackingAuthorizationStatus
    }
}


// MARK: - Initialization
extension SharedGoogleAdManager {
    static func initializeMobileAds() {
        GADMobileAds.sharedInstance().start()
    }
    
    static func requestTrackingAuthorization() async {
        await ATTrackingManager.requestTrackingAuthorization()
    }
}


// MARK: - Loader
extension SharedGoogleAdManager {
    static func loadAppOpenAd() async throws -> GADAppOpenAd {
        return try await GADAppOpenAd.load(withAdUnitID: AdMobId.openApp.unitId, request: .customInit(trackingAuthStatus: appTrackingAuthStatus))
    }
    
    static func loadInterstitialAd() async throws -> GADInterstitialAd {
        return try await GADInterstitialAd.load(withAdUnitID: AdMobId.interstitial.unitId, request: .customInit(trackingAuthStatus: appTrackingAuthStatus))
    }
}


// MARK: - Extension Dependencies
extension GADRequest {
    static func customInit(trackingAuthStatus: ATTrackingManager.AuthorizationStatus) -> GADRequest {
        let request = GADRequest()
        
        request.requestAgent = trackingAuthStatus.gadRequestAgent
        
        return request
    }
}

extension ATTrackingManager.AuthorizationStatus {
    var gadRequestAgent: String {
        switch self {
        case .authorized:
            return "Ads/GMA_IDFA"
        case .denied, .restricted:
            return "Ads/GMA"
        default:
            return ""
        }
    }
}
