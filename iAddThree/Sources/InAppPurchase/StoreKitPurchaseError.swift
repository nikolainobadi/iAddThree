//
//  StoreKitPurchaseError.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation
//import NnSwiftUIErrorHandling

enum ProUpgradeError: Error {
    case fetchProductsError
    case unverifiedTransaction
    case networkError
    case restorePurchaseSuccess
    case restorePurchaseError
}


// MARK: - CustomError
extension ProUpgradeError/*: NnDisplayableError*/ {
    var title: String {
        switch self {
        case .networkError:
            return "Bad Connection"
        case .unverifiedTransaction:
            return "Unverified Transaction"
        case .fetchProductsError:
            return "Loading Error"
        case .restorePurchaseSuccess:
            return "Success"
        case .restorePurchaseError:
            return "Restore Error"
        }
    }
    
    var message: String {
        let SUPPORT_EMAIL = "nnobadicares@gmail.com"
        
        switch self {
        case .networkError:
            return "Please move to a place with a better internet connection and try again."
        case .unverifiedTransaction:
            return "Your purhcase was NOT verified by Apple. If you think this is a mistake, please contact me at \(SUPPORT_EMAIL)"
        case .fetchProductsError:
            return "Unable to load info from the AppStore. Please try again later."
        case .restorePurchaseSuccess:
            return "If you've made any iAddThree purchases, they should now be restored. If not, try restarting the app. For further support, please contact me at \(SUPPORT_EMAIL)"
        case .restorePurchaseError:
            return "Unable to restore purchases. Please try again. If you still are unable to restore your purchases, please contact me at \(SUPPORT_EMAIL)"
        }
    }
}
