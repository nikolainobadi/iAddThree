//
//  ProUpgradeDataModelTests.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import XCTest
@testable import iAddThree

final class ProUpgradeDataModelTests: XCTestCase {
    func test_init_startingValuesEmpty() {
        let (sut, store, defaults) = makeSUT()
        
        XCTAssertNil(sut.error)
        XCTAssertTrue(sut.productName.isEmpty)
        XCTAssertTrue(sut.productPrice.isEmpty)
        XCTAssertTrue(store.name.isEmpty)
        XCTAssertTrue(store.price.isEmpty)
        XCTAssertNil(defaults.value(forKey: AppStorageKey.adsRemoved))
    }
    
    func test_fetchProduct() async throws {
        let (sut, store, _) = makeSUT()
        
        await sut.fetchProduct()
        try await waitForAsyncMethod()
        
        XCTAssertNil(sut.error)
        XCTAssertFalse(store.name.isEmpty)
        XCTAssertFalse(store.price.isEmpty)
        XCTAssertFalse(sut.productName.isEmpty)
        XCTAssertFalse(sut.productPrice.isEmpty)
    }
    
    func test_fetchProduct_error() async throws {
        let (sut, store, _) = makeSUT(throwError: true)
        
        await sut.fetchProduct()
        try await waitForAsyncMethod()
        
        XCTAssertNotNil(sut.error)
        XCTAssertTrue(store.name.isEmpty)
        XCTAssertTrue(store.price.isEmpty)
        XCTAssertTrue(sut.productName.isEmpty)
        XCTAssertTrue(sut.productPrice.isEmpty)
    }

//    func test_purchase() async {
//
//    }
//
//    func test_restorePurchases() async {
//
//    }
}


// MARK: - SUT
extension ProUpgradeDataModelTests {
    func makeSUT(throwError: Bool = false, shouldPurchase: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: ProUpgradeDataModel, store: MockStore, defaults: UserDefaults) {
        
        let defaults = MockUserDefaults(suiteName: #file)!
        let store = MockStore(throwError: throwError, shouldPurchase: shouldPurchase)
        let sut = ProUpgradeDataModel(store: store, defaults: defaults)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store, defaults)
    }
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
