//
//  GameViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class GameViewDataModel: ObservableObject {
    @Published var isPlaying = false
    
    private let mode: GameMode
    
    init(mode: GameMode) {
        self.mode = mode
    }
}


// MARK: - View Model
extension GameViewDataModel {
    var modeTitle: String { mode.title }
    
    func startGame() { isPlaying = true }
}


// MARK: - Dependencies
extension GameMode {
    var title: String {
        switch self {
        case .add: return "Add Three"
        }
    }
}
