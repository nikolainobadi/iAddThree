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
            VStack(spacing: 0) {
                DismissButton(dismiss: dismiss)
                Text("iAddThree Pro")
                    .setChalkFont(.title3)
            }.padding(.bottom, getHeightPercent(5))
            
            Text(dataModel.details)
                .padding()
                .setSmoothFont(.body)
                .withTextBackground()
            
            Spacer()
            Button(action: dataModel.purchasePro) {
                Text("Remove Ads")
            }
            
            Button(action: dataModel.restorePurchases) {
                Text("Restore Purchases")
                    .underline()
                    .setSmoothFont(.body)
            }
            
            Spacer()
        }
    }
}


// MARK: - Preview
struct ProUpgradeView_Previews: PreviewProvider {
    static var dataModel: ProUpgradeDataModel { ProUpgradeDataModel() }
    static var previews: some View {
        ProUpgradeView(dataModel: dataModel, dismiss: { })
            .onChalkboard()
    }
}
