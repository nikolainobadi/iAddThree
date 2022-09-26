//
//  AppRateManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/26/22.
//

import SwiftUI
import StoreKit

enum AppRateManager {
    static func requestAppReview() {
        Task {
            if Thread.isMainThread {
                showRequest()
            } else {
                await MainActor.run(body: {
                    showRequest()
                })
            }
        }
    }
}


private extension AppRateManager {
    static func showRequest() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}

