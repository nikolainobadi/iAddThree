//
//  DidPurchaseProKey.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI

struct DidPurchaseProKey: EnvironmentKey {
    static let defaultValue: Bool = false // Default value
}

public extension EnvironmentValues {
    var didPurchasePro: Bool {
        get { self[DidPurchaseProKey.self] }
        set { self[DidPurchaseProKey.self] = newValue }
    }
}
