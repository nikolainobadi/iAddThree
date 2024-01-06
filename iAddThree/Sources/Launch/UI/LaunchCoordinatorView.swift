//
//  LaunchCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIHelpers
import iAddThreeClassicKit

struct LaunchCoordinatorView: View {
    @State private var showingSplashScreen = true
    @State private var shouldShowAppOpenAdd = false
    @AppStorage(AppStorageKey.adsRemoved) private var adsRemoved = false
    @AppStorage(AppStorageKey.initialLaunch) private var isInitialLaunch = true
    
    private var canShowAds: Bool {
        return !isInitialLaunch && !adsRemoved
    }
    
    var body: some View {
        ZStack {
            if showingSplashScreen {
                SplashView()
                    .onlyShow(when: showingSplashScreen)
                    .delayedOnAppear(seconds: 2) {
                        shouldShowAppOpenAdd = true
                        waitAndPerform(delay: 0.5, withAnimation: .smooth) {
                            showingSplashScreen = false
                        }
                    }
            } else {
                MainFeaturesCoordinatorView()
                    .onAppear {
                        isInitialLaunch = false
                    }
            }
        }
        .onChalkboard()
        .appOpenAd(shouldShowAd: $shouldShowAppOpenAdd)
        .environment(\.canShowAds, canShowAds)
        .environment(\.didPurchasePro, adsRemoved)
        .onAppear {
            SharedGoogleAdManager.initializeMobileAds()
            SharedStoreKitManager.startTransactionListener(completion: { adsRemoved = $0 })
        }
    }
}


// MARK: - Preview
#Preview {
    LaunchCoordinatorView()
}
