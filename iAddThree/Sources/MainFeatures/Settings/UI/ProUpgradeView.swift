//
//  ProUpgradeView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI
import iAddThreeCore
import iAddThreeClassicKit

struct ProUpgradeView: View {
    @StateObject var viewModel: ProUpgradeViewModel
    
    let didPurchasePro: Bool
    
    var body: some View {
        VStack {
            ProUpgradeMessageView(message: viewModel.getMessage(isPro: didPurchasePro))
            ProUpgradeButtonView(viewModel: viewModel)
                .onlyShow(when: !didPurchasePro)
        }
        .asyncTask {
            try await viewModel.fetchProduct()
        }
    }
}


// MARK: - MessageView
fileprivate struct ProUpgradeMessageView: View {
    let message: String
    
    var body: some View {
        Text(message)
            .padding()
            .setChalkFont(.body, isSmooth: true)
            .withTextBackground()
            .multilineTextAlignment(.center)
            .framePercent(widthPercent: 98, heighPercent: 80)
            .padding(.bottom)
    }
}


// MARK: - ButtonView
fileprivate struct ProUpgradeButtonView: View {
    @ObservedObject var viewModel: ProUpgradeViewModel
    
    var body: some View {
        VStack {
            AsyncTryButton(action: viewModel.purchase) {
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
            
            AsyncTryButton(action: viewModel.restorePurchase) {
                Text("Restore Purchase")
                    .underline()
                    .setChalkFont(.body, isSmooth: true)
            }
            .padding()
        }
    }
}

// MARK: - Preview
#Preview {
    ProUpgradeView(viewModel: .init(store: InAppPurchaseStoreAdapter()), didPurchasePro: false)
        .onChalkboard()
}
