//
//  GameMode.swift
//  iAddThreeCore
//
//  Created by Nikolai Nobadi on 1/6/24.
//

/// `GameMode` represents the different modes available in the game.
/// It includes add, subtract, and hybrid modes.
@frozen
public enum GameMode: String, Identifiable, CaseIterable {
    case add, subtract, hybrid
    
    /// Unique identifier for each game mode.
    /// For hybrid mode, it returns just the name. For add and subtract, it appends "Three" to the name.
    public var id: String {
        return "\(name) \(self == .hybrid ? "" : "Three")"
    }
}

public extension GameMode {
    /// A computed property to get the capitalized name of the game mode.
    var name: String {
        return rawValue.capitalized
    }
}

