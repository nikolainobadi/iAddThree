//
//  AdMobComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI
import Foundation
import GoogleMobileAds

enum AdMobComposer {
    static func makeAdBannerView() -> some View {
        AdBannerView(adId: getId(.banner))
    }
    
    static func makeInterstitialLoader(shouldShowAd: Bool, completion: @escaping () -> Void) -> InterstitialAdLoader {
        InterstitialAdLoader(adId: getId(.interstitial), shouldShowAd: shouldShowAd, completion: completion)
    }
}


// MARK: - Private Methods
private extension AdMobComposer {
    static func getId(_ idType: AdMobId) -> String {
        #if DEBUG
        return idType.testId
        #else
        idType.rawValue
        #endif
    }
}


final class InterstitialAdLoader: NSObject {
    private let adId: String
    private let shouldShowAd: Bool
    private let completion: () -> Void
    
    private var interstitialAd: GADInterstitialAd?
    
    init(adId: String, shouldShowAd: Bool, completion: @escaping () -> Void) {
        self.adId = adId
        self.shouldShowAd = shouldShowAd
        self.completion = completion
        
        super.init()
        loadAd()
    }
    
    func showAd() {
        if let ad = interstitialAd, shouldShowAd {
            ad.show(failure: completion)
        } else {
            incrementAdActions()
            completion()
        }
    }
}


// MARK: - Delegate
extension InterstitialAdLoader: GADFullScreenContentDelegate {
    func adDidRecordClick(_ ad: GADFullScreenPresentingAd) { finished() }
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) { finished() }
}


// MARK: - Private Methods
private extension InterstitialAdLoader {
    func loadAd() {
        GADInterstitialAd.load(withAdUnitID: adId, request: GADRequest()) { [weak self] ad, error in
            guard error == nil else { return }
            
            self?.interstitialAd = ad
            self?.interstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    func incrementAdActions() {
        
    }
    
    func finished() {
        completion()
        loadAd()
    }
}


extension GADInterstitialAd {
    func show(failure: (() -> Void)? = nil) {
        let keyWindow = UIApplication.shared.connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            present(fromRootViewController: topController)
        } else {
            failure?()
        }
    }
}
