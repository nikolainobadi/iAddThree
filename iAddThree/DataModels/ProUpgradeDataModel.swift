//
//  ProUpgradeDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import StoreKit
import Foundation

final class ProUpgradeDataModel: ObservableObject {
    @Published private var product: Product?
}


// MARK: - View Model
extension ProUpgradeDataModel {
    var removeAdsMessage: String { "" }
    var thankYouMessage: String { "" }
    var productName: String { product?.displayName ?? "" }
    var productPrice: String {
        guard let price = product?.price else { return "" }
        
        return "\(price)"
    }
    
    func fetchProduct() async {
        do {
            if let product = try await Product.products(for: [InAppPurchaseProductKey.removeAds]).first {
                await setProduct(product)
            }
        } catch {
            // MARK: - TODO
            print(error)
        }
    }
    
    func purchase() {
        Task {
            do {
                guard let result = try await product?.purchase() else { return }
                
                await handlePurchaseResult(result)
            } catch {
                // MARK: - TODO
                print(error)
            }
        }
    }
    
    func restorePurchase() {
        // MARK: - TODO
    }
}


// MARK: - Private Methods
private extension ProUpgradeDataModel {
    
    
    @MainActor func setProduct(_ product: Product) { self.product = product }
    
    func handlePurchaseResult(_ result: Product.PurchaseResult) async {
        
    }
}


// MARK: - Dependencies
protocol InAppPurchaseStore {
    var productNamePublisher: Published<String>.Publisher { get }
    var productPricePublisher: Published<String>.Publisher { get }
    
    func fetchProducts() async throws
    func purchaseRemoveAdsEntitlement() async throws
    func restorePurchases() async throws // ideally should NOT be needed
}


