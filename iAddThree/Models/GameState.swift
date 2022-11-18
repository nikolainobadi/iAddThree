//
//  GameState.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import Foundation

enum GameState: Equatable {
    case menu
    case playing
    case results(LevelResults)
}
