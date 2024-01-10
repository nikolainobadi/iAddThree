//
//  LaunchCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import iAddThreeCore
import NnSwiftUIHelpers
import iAddThreeClassicKit

struct LaunchCoordinatorView: View {
    @State private var showingSplashScreen = true
    @State private var shouldShowAppOpenAdd = false
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage(AppStorageKey.adsRemoved) private var adsRemoved = false
    @AppStorage(AppStorageKey.initialLaunch) private var isInitialLaunch = true
    
    private var canShowAds: Bool {
        return !isInitialLaunch && !adsRemoved
    }
    
    private func gameCenterLogin() {
        SharedGameKitManager.authenticateLocalPlayer(presentingViewController: UIApplication.shared.getTopViewController())
    }
    
    var body: some View {
        ZStack {
            if showingSplashScreen {
                SplashView()
                    .onlyShow(when: showingSplashScreen)
                    .delayedOnAppear(seconds: 3) {
                        shouldShowAppOpenAdd = true
                        waitAndPerform(delay: 0.5, withAnimation: .smooth) {
                            showingSplashScreen = false
                        }
                    }
            } else {
                MainFeaturesCoordinatorView(viewModel: .customInit())
                    .onAppear {
                        isInitialLaunch = false
                        if !canShowAds {
                            gameCenterLogin()
                        }
                    }
            }
        }
        .onChalkboard()
        .appOpenAd(shouldShowAd: $shouldShowAppOpenAdd) {
            gameCenterLogin()
        }
        .environment(\.canShowAds, canShowAds)
        .environment(\.didPurchasePro, adsRemoved)
        .onAppear {
            SharedGoogleAdManager.initializeMobileAds()
            SharedStoreKitManager.startTransactionListener(completion: { adsRemoved = $0 })
        }
        .onChange(of: scenePhase) {
            if scenePhase == .active {
                shouldShowAppOpenAdd = true
            }
        }
    }
}


// MARK: - Preview
#Preview {
    LaunchCoordinatorView()
}


// MARK: - Extension Dependencies
extension MainFeaturesViewModel {
    static func customInit() -> MainFeaturesViewModel {
        return .init(store: UserDefaultsGamePerformanceStore())
    }
}
