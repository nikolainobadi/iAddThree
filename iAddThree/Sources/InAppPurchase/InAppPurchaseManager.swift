//
//  InAppPurchaseManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import StoreKit
import Foundation

final class InAppPurchaseManager {
    @Published private var product: Product?
    @Published private var removeAdsName: String = ""
    @Published private var removeAdsPrice: String = ""
    
    init() {
        $product.compactMap({ $0?.displayName }).assign(to: &$removeAdsName)
        $product.compactMap({ $0?.price }).map({ "\($0)" }).assign(to: &$removeAdsPrice)
    }
}


// MARK: - Store
extension InAppPurchaseManager: InAppPurchaseStore {
    var productNamePublisher: Published<String>.Publisher { $removeAdsName }
    var productPricePublisher: Published<String>.Publisher { $removeAdsPrice }
    
    func fetchProducts() async throws {
        product = try await Product.products(for: [InAppPurchaseProductKey.removeAds]).first
    }
    
    func purchaseRemoveAdsEntitlement() async throws -> Bool {
        guard let purchaseResult = try await product?.purchase() else { return false }
        
        switch purchaseResult {
        case .success(let successResult):
            let transaction = try TransactionResultVerifier.checkVerified(successResult)
            
            // purchase results handled in ProStatusManager
            
            await transaction.finish()
            
            return true
        case .userCancelled: return false
        case .pending: return false
        @unknown default: return false
        }
    }
    
    func restorePurchases() async -> Bool {
        return ((try? await AppStore.sync()) != nil)
    }
}


