//
//  ProUpgradeDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

final class ProUpgradeDataModel: ObservableObject {
    @Published var productName = ""
    @Published var productPrice = ""
    
    private let store: InAppPurchaseStore
    
    init(store: InAppPurchaseStore) {
        self.store = store
    }
}


// MARK: - View Model
extension ProUpgradeDataModel {
    var removeAdsMessage: String { "" }
    var thankYouMessage: String { "" }
    
    func fetchProduct() async {
        startListeners()
        
        do {
            try await store.fetchProducts()
        } catch {
            // MARK: - TODO
            print(error)
        }
    }
    
    func purchase() {
        Task {
            do {
                try await store.purchaseRemoveAdsEntitlement()
            } catch {
                // MARK: - TODO
                print(error)
            }
        }
    }
    
    func restorePurchase() {
        Task {
            do {
                try await store.restorePurchases()
            } catch {
                // MARK: - TODO
                print(error)
            }
        }
    }
}


// MARK: - Private Methods
private extension ProUpgradeDataModel {
    func startListeners() {
        store.productNamePublisher.dispatchOnMainQueue().assign(to: &$productName)
        store.productPricePublisher.dispatchOnMainQueue().assign(to: &$productPrice)
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
