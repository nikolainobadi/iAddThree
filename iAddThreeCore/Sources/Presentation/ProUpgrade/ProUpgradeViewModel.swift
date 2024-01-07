//
//  ProUpgradeViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation

fileprivate let MY_EMAIL = "nikolai.nobadi@gmail.com"

public final class ProUpgradeViewModel: ObservableObject {
    @Published public var productName = ""
    @Published public var productPrice = ""
    
    private let store: InAppPurchaseStore
    
    public init(store: InAppPurchaseStore) {
        self.store = store
    }
}


// MARK: - View Model
public extension ProUpgradeViewModel {
    func getMessage(isPro: Bool) -> String {
        return ProUpgradeMessage.makeMessageEnum(isPro: isPro).message
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


// MARK: - MainActor
@MainActor
private extension ProUpgradeViewModel {
    func updateProductInfo(name: String, price: String) {
        productName = name
        productPrice = price
    }
}


// MARK: - Dependencies
public protocol InAppPurchaseStore {
    typealias ProductInfo = (name: String, price: String)
    
    func fetchProducts() async throws -> ProductInfo
    func purchasePro() async throws
    func restorePurchases() async throws
}

enum ProUpgradeMessage {
    case removeAds, thankYou
    
    var message: String {
        switch self {
        case .removeAds:
            return """
        Tired of those pesky ads ruining your cognitive training?
        
        Why not remove them?
        
        And if the ads don't bother you, perhaps you can consider the purchase a small donation to help this independent iOS Developer make a living :)
        """
        case .thankYou:
            return """
        You, dear sir or ma'am, are truly a wonder.
        
        Thank your for the purchase. It may not seem like a lot, but each purchase helps provide me with what I need to continue building apps for the world!
        
        If you ever have any ideas/feedback (for iAddThree or any of my apps), please feel free to email me directly at \(MY_EMAIL)!
        """
        }
    }
    
    static func makeMessageEnum(isPro: Bool) -> ProUpgradeMessage {
        return isPro ? .thankYou : .removeAds
    }
}
