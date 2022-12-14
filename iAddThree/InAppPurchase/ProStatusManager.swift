//
//  ProStatusManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import StoreKit
import Foundation

final class ProStatusManager {
    @Published var removeAds = false
    
    var updateListenerTask: Task<Void, Error>? = nil
    
    init() {
        updateListenerTask = startTransactionListener()
        
        Task {
            await updateProStatus()
        }
    }
    
    deinit {
        updateListenerTask?.cancel()
    }
}


// MARK: - Publisher
extension ProStatusManager: ProStatusPublisher {
    var removeAdsPublisher: Published<Bool>.Publisher { $removeAds }
}


// MARK: - Private Methods
private extension ProStatusManager {
    func startTransactionListener() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try TransactionResultVerifier.checkVerified(result)
                    
                    await self.updateProStatus()
                    await transaction.finish()
                } catch {
                    // MARK: - TODO
                    print(error)
                }
            }
        }
    }
    
    @MainActor func updateProStatus() async {
        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try TransactionResultVerifier.checkVerified(result)
                
                removeAds = transaction.productID == InAppPurchaseProductKey.removeAds
                
                await transaction.finish()
            } catch {
                // MARK: - TODO
                print(error)
            }
        }
    }
}
