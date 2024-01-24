//
//  ModeLevelError+Extensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import NnSwiftUIKit
import iAddThreeCore

extension ModeLevelError: NnDisplayableError {
    public var title: String {
        return "Restricted"
    }
    
    public var message: String {
        switch self {
        case .subtract:
            return "Complete level 1 in 'Add' mode to unlock 'Subtract'."
        case .hybrid:
            return "Complete level 10 in 'Subtract' mode to unlock 'Hybrid'"
        case .unknown:
            return ""
        }
    }
}
