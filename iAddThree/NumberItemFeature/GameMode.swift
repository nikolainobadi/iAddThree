//
//  GameMode.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

enum GameMode: CaseIterable {
    case add, subtract
}

extension GameMode: Identifiable {
    var id: String {
        switch self {
        case .add: return "ADD_MODE"
        case .subtract: return "SUBTRACT_MODE"
        }
    }
}
