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
    @State private var didCallOnDismiss = false
    @Environment(\.canShowAds) var canShowAds: Bool
    
    let onDismissAd: (() -> Void)?
    
    private func callCompletionOnMainThread() {
        Task {
            await MainActor.run {
                onDismissAd?()
                didCallOnDismiss = true
            }
        }
    }
    
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
            .onChange(of: manager.didDismissAd) { _, didDismissAdd in
                if didDismissAdd && !didCallOnDismiss {
                    waitAndPerform(delay: 1) {
                        callCompletionOnMainThread()
                    }
                }
            }
    }
}

public extension View {
    func appOpenAd(shouldShowAd: Binding<Bool>, onDismissAd: (() -> Void)?) -> some View {
        modifier(AppOpenAdsViewModifier(shouldShowAd: shouldShowAd, manager: .init(), onDismissAd: onDismissAd))
    }
}
