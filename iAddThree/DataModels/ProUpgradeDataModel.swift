//
//  ProUpgradeDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

final class ProUpgradeDataModel: ObservableObject {
    
}


// MARK: - View Model
extension ProUpgradeDataModel {
    var isPro: Bool { false }
    var details: String { isPro ? thankYouMessage : proDetails }
    
    func purchasePro() { }
    func restorePurchases() { }
}


// MARK: - Private Methods
private extension ProUpgradeDataModel {
    var proDetails: String { "" }
    var thankYouMessage: String { "" }
}
