//
//  SharedStoreKitManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import StoreKit
import Foundation

enum SharedStoreKitManager {
    private static let removeAds = "com.nobadi.AddThree.RemoveAd"
    
    private static var product: Product?
}


// MARK: - Listener
extension SharedStoreKitManager {
    typealias RemoveAds = Bool
    static func startTransactionListener(completion: @escaping (RemoveAds) -> Void) {
        Task {
            for await result in Transaction.updates {
                do {
                    let transaction = try checkVerified(result)
                    
                    completion(transaction.productID == removeAds)
                    await transaction.finish()
                } catch {
                    print("Transaction verification failed: \(error)")
                }
            }
        }
    }
}


// MARK: - Fetch
extension SharedStoreKitManager {
    static func fetchProduct() async throws -> Product? {
        return try await Product.products(for: [removeAds]).first
    }
}


// MARK: - Purchase
extension SharedStoreKitManager {
    static func purchasePro() async throws  {
        let _ = try await product?.purchase()
    }
    
    static func restorePurchases() async throws {
        try await AppStore.sync()
    }
    
    static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreKitPurchaseError.unverifiedTransaction
        case .verified(let safe):
            return safe
        }
    }
}


// MARK: - Private Methods
private extension SharedStoreKitManager {
    static func executeStoreKitAction<T>(_ action: () async throws -> T) async throws -> T {
        do {
            return try await action()
        } catch {
            if let storeKitPurchaseError = error as? StoreKitPurchaseError {
                throw storeKitPurchaseError
            }
            
            throw StoreKitPurchaseError.other(error.localizedDescription)
        }
    }
}
