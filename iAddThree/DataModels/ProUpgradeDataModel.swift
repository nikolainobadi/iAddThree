//
//  ProUpgradeDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

final class ProUpgradeDataModel: ObservableObject {
    @Published var error: Error?
    @Published var productName = ""
    @Published var productPrice = ""
    
    private let store: InAppPurchaseStore
    private let defaults: UserDefaults
    private let myEmail = "nikolai.nobadi@gmail.com"
    
    init(store: InAppPurchaseStore, defaults: UserDefaults = UserDefaults.standard) {
        self.store = store
        self.defaults = defaults
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
            await showError(.networkError)
        }
    }
    
    func purchase() {
        Task {
            do {
                let didPurchase = try await store.purchaseRemoveAdsEntitlement()
                
                if didPurchase {
                    updateProStatus()
                }
            } catch {
                await showError(error as? ProUpgradeError ?? .networkError)
            }
        }
    }
    
    func restorePurchase() {
        Task {
            let didResetPurchases = await store.restorePurchases()
            
            // obviously success is not an 'error' but the success message in the alert will be useful anyway
            await showError(didResetPurchases ? .restorePurchaseSuccess : .restorePurchaseError)
        }
    }
}


// MARK: - Private Methods
private extension ProUpgradeDataModel {
    @MainActor func showError(_ error: ProUpgradeError) { self.error = error }
    
    func startListeners() {
        store.productNamePublisher.dispatchOnMainQueue().assign(to: &$productName)
        store.productPricePublisher.dispatchOnMainQueue().assign(to: &$productPrice)
    }
    
    func updateProStatus() {
        defaults.set(true, forKey: AppStorageKey.adsRemoved)
    }
}


// MARK: - Dependencies
protocol InAppPurchaseStore {
    var productNamePublisher: Published<String>.Publisher { get }
    var productPricePublisher: Published<String>.Publisher { get }
    
    func fetchProducts() async throws
    func purchaseRemoveAdsEntitlement() async throws -> Bool
    func restorePurchases() async -> Bool // ideally should NOT be needed
}
