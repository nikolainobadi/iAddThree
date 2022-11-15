//
//  GameMode.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

enum GameMode {
    case add
}

extension GameMode: Identifiable {
    var id: String {
        switch self {
        case .add: return "ADD_MODE"
        }
    }
}
