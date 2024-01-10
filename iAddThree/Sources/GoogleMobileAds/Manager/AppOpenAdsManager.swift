//
//  AppOpenAdsManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation
import GoogleMobileAds

final class AppOpenAdsManager: NSObject, ObservableObject {
    @Published var didDismissAd = false
    @Published var adToDisplay: FullScreenAdInfo<GADAppOpenAd>?
    
    private var nextAd: FullScreenAdInfo<GADAppOpenAd>?
}


// MARK: - Actions
extension AppOpenAdsManager {
    func showAd() {
        didDismissAd = false
        
        if SharedGoogleAdManager.didSetAuthStatus {
            setAdToDisplay()
        } else {
            requestTrackingAuth()
        }
    }
}


// MARK: - Delegate
extension AppOpenAdsManager: GADFullScreenContentDelegate {
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) { }
    func adDidRecordImpression(_ ad: GADFullScreenPresentingAd) { }
    
    func adWillDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        resetAds()
        loadNextAd()
        didDismissAd = true
    }
    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        resetAds()
        loadNextAd()
        
        print("App open ad failed to present with error: \(error.localizedDescription).")
    }
}

// MARK: - Private Methods
private extension AppOpenAdsManager {
    func setAdToDisplay() {
        if let nextAd = nextAd, !nextAd.isExpired {
            print("setting ad")
            adToDisplay = nextAd
        } else {
            print("loading next ad")
            loadNextAd()
        }
    }
    
    func requestTrackingAuth() {
        Task {
            await SharedGoogleAdManager.requestTrackingAuthorization()
        }
    }
    
    func resetAds() {
        nextAd = nil
        adToDisplay = nil
    }
    
    func loadNextAd() {
        Task {
            do {
                let ad = try await SharedGoogleAdManager.loadAppOpenAd()
                
                ad.fullScreenContentDelegate = self

                nextAd = .init(ad: ad)
            } catch {
                print(error)
                print("error loading ad", error.localizedDescription)
            }
        }
    }
}
