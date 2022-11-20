//
//  InAppPurchaseManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
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
    
    func purchaseRemoveAdsEntitlement() async throws {
        guard let purchaseResult = try await product?.purchase() else { return }
        
        switch purchaseResult {
        case .success(let successResult):
            let transaction = try TransactionResultVerifier.checkVerified(successResult)
            
            // purchase results handled in ProStatusManager
            
            await transaction.finish()
        case .userCancelled: break
        case .pending: break
        @unknown default: break
        }
    }
    
    func restorePurchases() async throws {
        // MARK: - TODO
    }
}

