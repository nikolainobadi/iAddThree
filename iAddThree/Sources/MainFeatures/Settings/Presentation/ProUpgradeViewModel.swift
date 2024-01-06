//
//  ProUpgradeViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation

final class ProUpgradeViewModel: ObservableObject {
    @Published var productName = ""
    @Published var productPrice = ""
    
    private let store: InAppPurchaseStore
    private let defaults: UserDefaults
    private let myEmail = "nikolai.nobadi@gmail.com"
    
    init(productName: String = "", productPrice: String = "", store: InAppPurchaseStore, defaults: UserDefaults = UserDefaults.standard) {
        self.productName = productName
        self.productPrice = productPrice
        self.store = store
        self.defaults = defaults
    }
}


// MARK: - View Model
extension ProUpgradeViewModel {
    func getMessage(isPro: Bool) -> String {
        return isPro ? thankYouMessage : removeAdsMessage
    }
    
    func fetchProduct() async throws {
        let (name, price) = try await store.fetchProducts()
        
        await updateProductInfo(name: name, price: price)
    }
    
    func purchase() async throws {
        try await store.purchasePro()
    }
    
    func restorePurchase() async throws {
        try await store.restorePurchases()
    }
}


// MARK: - Private
private extension ProUpgradeViewModel {
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
}


// MARK: - MainActor
@MainActor
private extension ProUpgradeViewModel {
    func updateProductInfo(name: String, price: String) {
        productName = name
        productPrice = price
    }
}


// MARK: - Dependencies
protocol InAppPurchaseStore {
    typealias ProductInfo = (name: String, price: String)
    
    func fetchProducts() async throws -> ProductInfo
    func purchasePro() async throws
    func restorePurchases() async throws
}

