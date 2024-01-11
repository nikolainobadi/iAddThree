//
//  ProUpgradeViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import Foundation

fileprivate let MY_EMAIL = "nikolai.nobadi@gmail.com"

/// `ProUpgradeViewModel` manages the view logic for handling in-app purchases, specifically for a pro upgrade.
public final class ProUpgradeViewModel: ObservableObject {
    /// Name of the product for display.
    @Published public var productName = ""

    /// Price of the product for display.
    @Published public var productPrice = ""
    
    /// Store for handling in-app purchase related actions.
    private let store: InAppPurchaseStore
    
    /// Initializes a new instance of `ProUpgradeViewModel`.
    /// - Parameter store: An `InAppPurchaseStore` instance to handle purchase-related actions.
    public init(store: InAppPurchaseStore) {
        self.store = store
    }
}

// MARK: - View Model
public extension ProUpgradeViewModel {
    /// Retrieves a message based on the user's purchase status.
    /// - Parameter isPro: A Boolean indicating whether the user has upgraded to Pro.
    /// - Returns: A string message relevant to the user's purchase status.
    func getMessage(isPro: Bool) -> String {
        return ProUpgradeMessage.makeMessageEnum(isPro: isPro).message
    }
    
    /// Fetches the product information for display.
    func fetchProduct() async throws {
        let (name, price) = try await store.fetchProducts()
        await updateProductInfo(name: name, price: price)
    }
    
    /// Initiates the purchase process for the pro upgrade.
    func purchase() async throws {
        try await store.purchasePro()
    }
    
    /// Restores previous purchases.
    func restorePurchase() async throws {
        try await store.restorePurchases()
    }
}

// MARK: - MainActor
@MainActor
private extension ProUpgradeViewModel {
    /// Updates the product information for display.
    /// - Parameters:
    ///   - name: Name of the product.
    ///   - price: Price of the product.
    func updateProductInfo(name: String, price: String) {
        productName = name
        productPrice = price
    }
}

// MARK: - Dependencies
/// Protocol defining the necessary methods for an in-app purchase store.
public protocol InAppPurchaseStore {
    typealias ProductInfo = (name: String, price: String)
    
    /// Fetches the product information.
    /// - Returns: A tuple containing the name and price of the product.
    func fetchProducts() async throws -> ProductInfo

    /// Initiates the purchase process for the pro upgrade.
    func purchasePro() async throws

    /// Restores previous purchases.
    func restorePurchases() async throws
}

/// Enumeration to define upgrade messages based on user's purchase status.
enum ProUpgradeMessage {
    case removeAds, thankYou
    
    /// The message string associated with the upgrade message.
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
    
    /// Factory method to create the appropriate message enum based on purchase status.
    /// - Parameter isPro: A Boolean indicating whether the user has upgraded to Pro.
    /// - Returns: A `ProUpgradeMessage` instance appropriate for the user's purchase status.
    static func makeMessageEnum(isPro: Bool) -> ProUpgradeMessage {
        return isPro ? .thankYou : .removeAds
    }
}

