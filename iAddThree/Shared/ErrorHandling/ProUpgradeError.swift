//
//  ProUpgradeError.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import Foundation

enum ProUpgradeError: Error {
    case fetchProductsError
    case unverifiedTransaction
    case networkError
}

extension ProUpgradeError: CustomError {
    var title: String? {
        switch self {
        case .networkError: return "Bad Connection"
        case .unverifiedTransaction: return "Unverified Transaction"
        case .fetchProductsError: return "Loading Error"
        }
    }
    
    var message: String {
        switch self {
        case .networkError: return "Please move to a place with a better internet connection and try again."
        case .unverifiedTransaction: return "Your purhcase was NOT verified by Apple. If you think this is a mistake, please contact me at \(SUPPORT_EMAIL)"
        case .fetchProductsError: return "Unable to load info from the AppStore. Please try again later."
        }
    }
    
    var suggestion: String? { nil }
}
