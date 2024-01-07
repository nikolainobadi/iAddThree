//
//  GameMode.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/6/24.
//

@frozen
public enum GameMode: String, Identifiable, CaseIterable {
    case add, subtract, hybrid
    
    public var id: String {
        return "\(name) \(self == .hybrid ? "" : "Three")"
    }
}

public extension GameMode {
    var name: String {
        return rawValue.capitalized
    }
}
