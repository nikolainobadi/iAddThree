//
//  ProUpgradeDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import StoreKit
import Foundation

enum InAppPurchaseProductKey {
    static let removeAds = "com.nobadi.AddThree.RemoveAd"
}

final class ProUpgradeDataModel: ObservableObject {
    @Published private var product: Product?
}


// MARK: - View Model
extension ProUpgradeDataModel {
    var isPro: Bool { false }
    var details: String { isPro ? thankYouMessage : proDetails }
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
    var proDetails: String { "" }
    var thankYouMessage: String { "" }
    
    @MainActor func setProduct(_ product: Product) { self.product = product }
    
    func handlePurchaseResult(_ result: Product.PurchaseResult) async {
        switch result {
        case .success(let verification):
            switch verification {
            case .verified(let transaction):
                // MARK: - TODO
                // update pro status
                await transaction.finish()
            case .unverified: break
            }
        case .userCancelled: break
        case .pending: break
        @unknown default: break
        }
    }
}
