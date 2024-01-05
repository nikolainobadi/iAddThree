//
//  TransactionResultVerifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import StoreKit
import Foundation

enum TransactionResultVerifier {
    static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified: throw ProUpgradeError.unverifiedTransaction
        case .verified(let safe): return safe
        }
    }
}
