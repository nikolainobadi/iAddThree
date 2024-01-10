//
//  InAppPurchaseStoreAdapter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import StoreKit
import Foundation
import iAddThreeCore

final class InAppPurchaseStoreAdapter: InAppPurchaseStore {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    func fetchProducts() async throws -> ProductInfo {
        guard let product = try await SharedStoreKitManager.fetchProduct() else {
            throw StoreKitPurchaseError.fetchProductsError
        }
        
        return (product.displayName, "\(product.price)")
    }
    
    func purchasePro() async throws {
        try await handlePurchaseAction {
            if let transaction = try await SharedStoreKitManager.purchasePro() {
                defaults.setValue(true, forKey: AppStorageKey.adsRemoved)
                await transaction.finish()
            }
        }
    }
    
    func restorePurchases() async throws {
        try await handlePurchaseAction {
            try await SharedStoreKitManager.restorePurchases()            
        }
    }
}


// MARK: - Private Methods
private extension InAppPurchaseStoreAdapter {
    func handlePurchaseAction(_ action: () async throws -> Void) async throws{
        do {
            SharedAdStateManager.isPurchasingPro = true
            
            try await action()
            
            SharedAdStateManager.isPurchasingPro = false
        } catch {
            SharedAdStateManager.isPurchasingPro = false
            throw error
        }
    }
}
