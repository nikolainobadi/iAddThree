//
//  FullScreenAdInfo.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import NnSwiftUIKit
import GoogleMobileAds

struct FullScreenAdInfo<Ad: GADFullScreenPresentingAd>: Identifiable {
    let ad: Ad
    let id: String
    let loadTime: Date
    
    init(ad: Ad, id: String = UUID().uuidString, loadTime: Date = Date()) {
        self.ad = ad
        self.id = id
        self.loadTime = loadTime
    }
}


// MARK: - Equatable
extension FullScreenAdInfo: Equatable {
    static func == (lhs: FullScreenAdInfo<Ad>, rhs: FullScreenAdInfo<Ad>) -> Bool {
        return lhs.id == rhs.id
    }
}


// MARK: - Helpers
extension FullScreenAdInfo {
    var isExpired: Bool {
        let freshnessInterval: TimeInterval = 4 * 3_600 // 4 hours
        
        return Date().timeIntervalSince(loadTime) > freshnessInterval
    }
    
    func showAd(failure: (() -> Void)? = nil) {
        guard var topController = UIApplication.shared.getTopViewController() else {
            failure?()
            return
        }

        while let presentedViewController = topController.presentedViewController {
            topController = presentedViewController
        }

        if let interstitialAd = ad as? GADInterstitialAd {
            interstitialAd.present(fromRootViewController: topController)
        } else if let appOpenAd = ad as? GADAppOpenAd {
            appOpenAd.present(fromRootViewController: topController)
        } else {
            failure?()
        }
    }
}
