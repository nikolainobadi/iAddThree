//
//  AppRater.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import UIKit
import StoreKit

enum AppRater {
    static func rateApp() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
}
