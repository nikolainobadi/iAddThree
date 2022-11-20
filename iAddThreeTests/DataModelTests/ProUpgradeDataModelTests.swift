//
//  ProUpgradeDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import XCTest
@testable import iAddThree

final class ProUpgradeDataModelTests: XCTestCase {
    
    
}


// MARK: - SUT
extension ProUpgradeDataModelTests {
//    func makeSUT(throwError: Bool = false, shouldPurchase: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: ProUpgradeDataModel, store: MockStore) {
//        let store = MockStore(throwError: throwError, shouldPurchase: shouldPurchase)
//        let sut = ProUpgradeDataModel(store: store, defaults: <#T##UserDefaults#>)
//    }
}


// MARK: - Helper Classes
extension ProUpgradeDataModelTests {
    class MockStore: InAppPurchaseStore {
        @Published var name = ""
        @Published var price = ""

        private let throwError: Bool
        private let shouldPurchase: Bool
        
        init(throwError: Bool, shouldPurchase: Bool) {
            self.throwError = throwError
            self.shouldPurchase = shouldPurchase
        }
        
        var purchasesRestored = false
        var productNamePublisher: Published<String>.Publisher { $name }
        var productPricePublisher: Published<String>.Publisher { $price }
        
        func fetchProducts() async throws {
            if throwError { throw ProUpgradeError.networkError }
            
            name = "Remove Ads"
            price = "$0.99"
        }
        
        func purchaseRemoveAdsEntitlement() async throws -> Bool {
            if throwError { throw ProUpgradeError.networkError }
            
            return shouldPurchase
        }
        
        func restorePurchases() async throws {
            if throwError { throw ProUpgradeError.networkError }
            
            purchasesRestored = true
        }
    }
}
