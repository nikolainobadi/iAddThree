//
//  AdMobComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI
import Foundation

enum AdMobComposer {
    static func makeAdBannerView() -> some View {
        AdBannerView(adId: getId(.banner))
    }
}


// MARK: - Private Methods
private extension AdMobComposer {
    static func getId(_ idType: AdMobId) -> String {
        #if DEBUG
        return idType.testId
        #else
        idType.rawValue
        #endif
    }
}
