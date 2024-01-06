//
//  AppOpenAdsViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI
import GoogleMobileAds

struct AppOpenAdsViewModifier: ViewModifier {
    @Binding var shouldShowAd: Bool
    @StateObject var manager: AppOpenAdsManager
    @Environment(\.canShowAds) var canShowAds: Bool
    
    func body(content: Content) -> some View {
        content
            .onChange(of: shouldShowAd) {
                if shouldShowAd && canShowAds {
                    manager.showAd()
                    shouldShowAd = false
                }
            }
            .onChange(of: manager.adToDisplay, { _, adToDisplay in
                adToDisplay?.showAd()
            })
    }
}

public extension View {
    func appOpenAd(shouldShowAd: Binding<Bool>) -> some View {
        modifier(AppOpenAdsViewModifier(shouldShowAd: shouldShowAd, manager: .init()))
    }
}
