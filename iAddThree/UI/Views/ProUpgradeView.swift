//
//  ProUpgradeView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct ProUpgradeView: View {
    @StateObject var dataModel: ProUpgradeDataModel
    
    let dismiss: () -> Void
    
    var body: some View {
        VStack {
            ProHeaderView(dismiss: dismiss)
            ProDetails(details: dataModel.details)
            PurchaseButtons(dataModel: dataModel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            await dataModel.fetchProduct()
        }
    }
}


// MARK: - Header
fileprivate struct ProHeaderView: View {
    let dismiss: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            DismissButton(dismiss: dismiss)
            Text("iAddThree Pro")
                .setChalkFont(.title3)
        }.padding(.bottom, getHeightPercent(5))
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
    }
}



// MARK: - PurchaseButtons
fileprivate struct PurchaseButtons: View {
    @ObservedObject var dataModel: ProUpgradeDataModel
    
    private var showPurchaseButton: Bool { !dataModel.isPro }
    
    var body: some View {
        VStack {
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
            }
            
            Button(action: dataModel.restorePurchase) {
                Text("Restore Purchases")
                    .underline()
                    .setSmoothFont(.body)
            }.padding(.top)
        }
        .padding()
        .withTextBackground(opacity: 0.2)
    }
}


// MARK: - Preview
struct ProUpgradeView_Previews: PreviewProvider {
    static var dataModel: ProUpgradeDataModel { ProUpgradeDataModel() }
    static var previews: some View {
        ProUpgradeView(dataModel: dataModel, dismiss: { })
            .onChalkboard()
        
        ProUpgradeView(dataModel: dataModel, dismiss: { })
            .onChalkboard()
            .preferredColorScheme(.dark)
    }
}
