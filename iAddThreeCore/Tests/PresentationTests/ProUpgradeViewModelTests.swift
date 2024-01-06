//
//  ProUpgradeViewModelTests.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import XCTest
@testable import iAddThreeCore

final class ProUpgradeViewModelTests: XCTestCase {
    func test_init_startingValues() {
        let (sut, store) = makeSUT()
        
        XCTAssertTrue(sut.productName.isEmpty)
        XCTAssertTrue(sut.productPrice.isEmpty)
        XCTAssertFalse(store.didPurchasePro)
        XCTAssertFalse(store.didRestorePurchases)
    }
    
    func test_getMessage_notPro_returnsRemoveAdsMessage() {
        XCTAssertEqual(makeSUT().sut.getMessage(isPro: false), ProUpgradeMessage.removeAds.message)
    }
    
    func test_getMessage_isPro_returnsThankYouMessage() {
        XCTAssertEqual(makeSUT().sut.getMessage(isPro: true), ProUpgradeMessage.thankYou.message)
    }
    
    func test_fetchProduct_onSuccess_updatesNameAndPrice() async throws {
        let (sut, _) = makeSUT()

        try await sut.fetchProduct()

        XCTAssertEqual(sut.productName, "RemoveAds")
        XCTAssertEqual(sut.productPrice, "$0.99")
    }

    func test_fetchProduct_onError_throwsError_nameAndPriceRemainEmpty() async {
        let (sut, _) = makeSUT(throwError: true)
        
        do {
            try await sut.fetchProduct()
            XCTFail("Expected an error, but fetchProduct succeeded")
        } catch {
            XCTAssertTrue(sut.productName.isEmpty)
            XCTAssertTrue(sut.productPrice.isEmpty)
        }
    }
    
    func test_purchase_onSuccess_noErrorsThrown() async throws {
        let (sut, store) = makeSUT()

        try await sut.purchase()

        XCTAssertTrue(store.didPurchasePro)
    }

    func test_purchase_onError_throwsError() async {
        let (sut, store) = makeSUT(throwError: true)

        do {
            try await sut.purchase()
            XCTFail("Expected an error, but purchase succeeded")
        } catch {
            XCTAssertFalse(store.didPurchasePro)
        }
    }
    
    func test_restorePurchase_onSuccess_noErrorsThrown() async throws {
        let (sut, store) = makeSUT()

        try await sut.restorePurchase()

        XCTAssertTrue(store.didRestorePurchases)
    }
    
    func test_restorePurchase_onError_throwsError() async {
        let (sut, store) = makeSUT(throwError: true)

        do {
            try await sut.restorePurchase()
            XCTFail("Expected an error, but restorePurchase succeeded")
        } catch {
            XCTAssertFalse(store.didRestorePurchases)
        }
    }
}


// MARK: - SUT
extension ProUpgradeViewModelTests {
    func makeSUT(name: String = "RemoveAds", price: String = "$0.99", throwError: Bool = false, file: StaticString = #filePath, line: UInt = #line) -> (sut: ProUpgradeViewModel, store: MockStore) {
        
        let store = MockStore(name: name, price: price, throwError: throwError)
        let sut = ProUpgradeViewModel(store: store)
        
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, store)
    }
}


// MARK: - Helper Classes
extension ProUpgradeViewModelTests {
    class MockStore: InAppPurchaseStore {
        private let info: ProductInfo
        private let throwError: Bool
        
        private(set) var didPurchasePro = false
        private(set) var didRestorePurchases = false
        
        init(name: String, price: String, throwError: Bool) {
            self.info = (name, price)
            self.throwError = throwError
        }
        
        func fetchProducts() async throws -> ProductInfo {
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            return info
        }
        
        func purchasePro() async throws {
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            didPurchasePro = true
        }
        
        func restorePurchases() async throws { 
            if throwError { throw NSError(domain: "Test", code: 0) }
            
            didRestorePurchases = true
        }
    }
}
