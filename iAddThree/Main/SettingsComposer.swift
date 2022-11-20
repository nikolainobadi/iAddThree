//
//  SettingsComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI
import Foundation

enum SettingsComposer {
    static func makeSettingsView() -> some View {
        let dataModel = SettingsDataModel(versionNumber: appVersionNumber, requestAppReview: AppRateManager.requestAppReview)
        
        return SettingsView(dataModel: dataModel)
    }
    
    static func makeProUpgradeView() -> some View {
        return ProUpgradeView(dataModel: ProUpgradeDataModel(store: InAppPurchaseManager()))
    }
}


// MARK: - Private Methods
private extension SettingsComposer {
    static var appVersionNumber: String? { Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String }
}
