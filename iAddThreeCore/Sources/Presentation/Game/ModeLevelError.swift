//
//  ModeLevelError.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation

/// `ModeLevelError` represents the types of errors that can occur related to game mode levels.
/// It includes errors for subtract, hybrid, and unknown types.
@frozen
public enum ModeLevelError: Error {
    case subtract, hybrid, unknown
}

