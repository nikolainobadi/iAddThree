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
    private static var updateListenerTask: Task<Void, Error>?
}


// MARK: - Listener
extension SharedStoreKitManager {
    typealias RemoveAds = Bool
    static func startTransactionListener(completion: @escaping (RemoveAds) -> Void) {
        updateListenerTask = Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try checkVerified(result)
                    
                    completion(transaction.productID == removeAds)
                    
                    await transaction.finish()
                } catch {
                    print("transaction error: ", error.localizedDescription)
                }
            }
        }
    }
}


// MARK: - Fetch
extension SharedStoreKitManager {
    static func fetchProduct() async throws -> Product? {
        let product = try await Product.products(for: [removeAds]).first
        
        self.product = product
        
        return product
    }
}


// MARK: - Purchase
extension SharedStoreKitManager {
    static func purchasePro() async throws -> Transaction?  {
        guard let product = product else {
            throw StoreKitPurchaseError.fetchProductsError
        }
        
        let result = try await product.purchase()
        
        switch result {
        case .success(let successResult):
            return try checkVerified(successResult)
        case .userCancelled:
            print("user cancelled transaction")
            return nil
        default:
            return nil
        }
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
