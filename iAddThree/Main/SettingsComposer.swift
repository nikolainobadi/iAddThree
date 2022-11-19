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
        let dataModel = SettingsDataModel(versionNumber: getAppVerionNumber(), requestAppReview: AppRateManager.requestAppReview)
        
        return SettingsView(dataModel: dataModel)
    }
}


// MARK: - Private Methods
private extension SettingsComposer {
    static func getAppVerionNumber() -> String? {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
}
