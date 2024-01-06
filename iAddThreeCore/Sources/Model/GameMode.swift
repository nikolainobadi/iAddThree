//
//  GameMode.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/6/24.
//

enum GameMode: String {
    case add, subtract, hybrid
}

extension GameMode: Identifiable {
    var id: String {
        return "\(name) \(self == .hybrid ? "" : "Three")"
    }
    
    var name: String {
        return rawValue.capitalized
    }
}
