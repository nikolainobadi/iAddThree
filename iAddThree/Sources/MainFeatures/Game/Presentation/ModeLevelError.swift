//
//  ModeLevelError.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation
import NnSwiftUIErrorHandling

enum ModeLevelError: Error {
    case subtract, hybrid, unknown
}


// MARK: - DisplayableError
extension ModeLevelError: NnDisplayableError {
    var title: String {
        return "Restricted"
    }
    
    var message: String {
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
