//
//  ProStatusManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import StoreKit
import Foundation

enum StoreError: Error {
    case failedVerification
}

final class ProStatusManager {
    @Published var isPro = false
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    init() {
       updateListenerTask = startTransactionListener()
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
}


// MARK: - Private Methods
private extension ProStatusManager {
    func startTransactionListener() -> Task<Void, Error> {
        return Task {
            for await result in Transaction.updates {
                do {
                    let transaction = try TransactionResultVerifier.checkVerified(result)
                    
                    await updateProStatus()
                    await transaction.finish()
                } catch {
                    // MARK: - TODO
                    print(error)
                }
            }
        }
    }
    
    @MainActor func updateProStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try TransactionResultVerifier.checkVerified(result)
                
                isPro = transaction.productID == InAppPurchaseProductKey.removeAds
                
                await transaction.finish()
            } catch {
                // MARK: - TODO
                print(error)
            }
        }
    }
}

enum TransactionResultVerifier {
    static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified: throw StoreError.failedVerification
        case .verified(let safe): return safe
        }
    }
}
