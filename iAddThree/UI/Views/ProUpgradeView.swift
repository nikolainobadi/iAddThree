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
            Text(dataModel.details)
                .padding()
                .setSmoothFont(.body)
                .withTextBackground()
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
}
