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
    private let myEmail = "nikolai.nobadi@gmail.com"
    
    init(store: InAppPurchaseStore) {
        self.store = store
    }
}


// MARK: - View Model
extension ProUpgradeDataModel {
    var removeAdsMessage: String {
        """
        Tired of those pesky ads ruining your cognitive training?
        
        Why not remove them?
        
        And if the ads don't bother you, perhaps you can consider the purchase a small donation to help this independent iOS Developer make a living :)
        """
    }
    
    var thankYouMessage: String {
        """
        You, dear sir or ma'am, are truly a wonder.
        
        Thank your for the purchase. It may not seem like a lot, but each purchase helps provide me with what I need to continue building apps for the world!
        
        If you ever have any ideas/feedback (for iAddThree or any of my apps), please feel free to email me directly at \(myEmail)!
        """
    }
    
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
