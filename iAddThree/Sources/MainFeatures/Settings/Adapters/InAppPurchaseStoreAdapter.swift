//
//  InAppPurchaseStoreAdapter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import StoreKit
import Foundation

final class InAppPurchaseStoreAdapter: InAppPurchaseStore {
    func fetchProducts() async throws -> ProductInfo {
        guard let product = try await SharedStoreKitManager.fetchProduct() else {
            throw StoreKitPurchaseError.fetchProductsError
        }
        
        return (product.displayName, "\(product.price)")
    }
    
    func purchasePro() async throws {
        try await SharedStoreKitManager.purchasePro()
    }
    
    func restorePurchases() async throws {
        try await SharedStoreKitManager.restorePurchases()
    }
}
