//
//  ProUpgradeView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct ProUpgradeView: View {
    @StateObject var dataModel: ProUpgradeDataModel
    @AppStorage(AppStorageKey.adsRemoved) var removeAds: Bool = false
    
    private var showPurchaseButton: Bool { !removeAds }
    private var details: String { removeAds ? dataModel.thankYouMessage : dataModel.removeAdsMessage }
    
    var body: some View {
        VStack {
            ProDetails(details: details)
                .padding(.bottom)
            PurchaseButtons(dataModel: dataModel, showPurchaseButton: showPurchaseButton)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            await dataModel.fetchProduct()
        }
    }
}


// MARK: - Details
fileprivate struct ProDetails: View {
    let details: String
    
    var body: some View {
        Text(details)
            .padding()
            .setSmoothFont(.body)
            .withTextBackground()
            .multilineTextAlignment(.center)
            .frame(maxWidth: getWidthPercent(98))
    }
}



// MARK: - PurchaseButtons
fileprivate struct PurchaseButtons: View {
    @ObservedObject var dataModel: ProUpgradeDataModel
    
    let showPurchaseButton: Bool
    
    var body: some View {
        if showPurchaseButton {
            Button(action: dataModel.purchase) {
                VStack {
                    Text(dataModel.productName)
                        .setSmoothFont(.headline)
                    
                    Text(dataModel.productPrice)
                        .setSmoothFont(.body)
                }.padding(.horizontal)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
            .shadow(color: .black, radius: 4, x: 2, y: 2)
            .padding()
        } else {
            Button(action: dataModel.restorePurchase) {
                Text("Restore Purchases")
                    .underline()
                    .setSmoothFont(.body)
            }.padding()
        }
    }
}


// MARK: - Preview
struct ProUpgradeView_Previews: PreviewProvider {
    class MockStore: InAppPurchaseStore {
        @Published var name = "Remove Ads"
        @Published var price = "$0.99"
        
        var productNamePublisher: Published<String>.Publisher { $name }
        var productPricePublisher: Published<String>.Publisher { $price }
        
        func fetchProducts() async throws { }
        func purchaseRemoveAdsEntitlement() async throws { }
        func restorePurchases() async throws { }
    }
    
    static var dataModel: ProUpgradeDataModel { ProUpgradeDataModel(store: MockStore()) }
    static var previews: some View {
        ProUpgradeView(dataModel: dataModel)
            .onChalkboard()
        
        ProUpgradeView(dataModel: dataModel)
            .onChalkboard()
            .preferredColorScheme(.dark)
    }
}
