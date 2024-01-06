//
//  ProUpgradeView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI
import NnSwiftUIHelpers
import iAddThreeClassicKit
import NnSwiftUIErrorHandling

struct ProUpgradeView: View {
    @StateObject var viewModel: ProUpgradeViewModel
    
    let didPurchasePro: Bool
    
    var body: some View {
        VStack {
            Text(viewModel.getMessage(isPro: didPurchasePro))
                .padding()
                .setChalkFont(.body, isSmooth: true)
//                .withTextBackground()
                .multilineTextAlignment(.center)
                .framePercent(widthPercent: 98, heighPercent: 80)
                .padding(.bottom)
            
            VStack {
                NnAsyncTryButton(action: viewModel.purchase) {
                    VStack {
                        Text(viewModel.productName)
                            .setChalkFont(.headline, isSmooth: true)
                        
                        Text(viewModel.productPrice)
                            .setChalkFont(.body, isSmooth: true)
                    }
                    .padding(.horizontal)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .shadow(color: .black, radius: 4, x: 2, y: 2)
                .padding()
                
                NnAsyncTryButton(action: viewModel.restorePurchase) {
                    Text("Restore Purchase")
                        .underline()
                        .setChalkFont(.body, isSmooth: true)
                }
                .padding()
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = ProUpgradeViewModel(productName: "Remove Ads", productPrice: "$0.99", store: InAppPurchaseStoreAdapter())
    
    return ProUpgradeView(viewModel: viewModel, didPurchasePro: false)
        .onChalkboard()
}
