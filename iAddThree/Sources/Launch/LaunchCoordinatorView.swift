//
//  LaunchCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import iAddThreeCore
import iAddThreeClassicKit

struct LaunchCoordinatorView: View {
    @State private var showingSplashScreen = true
    @State private var shouldShowAppOpenAdd = false
    @Environment(\.scenePhase) private var scenePhase
    @AppStorage(OldAppStorageKey.adsRemoved) private var adsRemoved = false
    
    private var canShowAds: Bool {
        return !adsRemoved && !SharedAdStateManager.isPurchasingPro
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
            }
        }
        .onChalkboard()
        .appOpenAd(shouldShowAd: $shouldShowAppOpenAdd, onDismissAd: nil)
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


struct IsProUITestViewModifier: ViewModifier {
    @AppStorage(OldAppStorageKey.adsRemoved) private var adsRemoved = false
    
    var isProTester: Bool {
        return ProcessInfo.processInfo.arguments.contains("IsProForUITest")
    }
    
    func body(content: Content) -> some View {
        content
            .onAppear {
                print("IS PRO IN UI TESTING:", adsRemoved)
            }
    }
}

extension View {
    func isProForUITesing() -> some View {
        modifier(IsProUITestViewModifier())
    }
}
