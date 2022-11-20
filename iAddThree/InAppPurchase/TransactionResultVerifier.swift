//
//  TransactionResultVerifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import StoreKit
import Foundation

enum TransactionResultVerifier {
    static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified: throw StoreError.failedVerification
        case .verified(let safe): return safe
        }
    }
}
