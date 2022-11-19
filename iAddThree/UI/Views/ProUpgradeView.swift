//
//  ProUpgradeView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct ProUpgradeView: View {
    @StateObject var dataModel: ProUpgradeDataModel
    
    var body: some View {
        VStack {
            Text("iAddThree Pro")
                .setChalkFont(.title3)
                .padding()
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

struct ProUpgradeView_Previews: PreviewProvider {
    static var dataModel: ProUpgradeDataModel { ProUpgradeDataModel() }
    static var previews: some View {
        ProUpgradeView(dataModel: dataModel)
            .onChalkboard()
    }
}

final class ProUpgradeDataModel: ObservableObject {
    
}

extension ProUpgradeDataModel {
    var isPro: Bool { false }
    var details: String { "pro upgrade details" }
    
    func purchasePro() { }
    func restorePurchases() { }
}
