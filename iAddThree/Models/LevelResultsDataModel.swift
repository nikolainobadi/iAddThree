//
//  LevelResultsDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

final class LevelResultsDataModel: ObservableObject {
    @Published var currentScore: Int
    @Published var showingGameOver = false
    
    private let newScore: Int?
    private let previousLevel: Int
    
    let playNextLevel: () -> Void
    
    init(currentScore: Int, newScore: Int?, previousLevel: Int, playNextLevel: @escaping () -> Void) {
        self.currentScore = currentScore
        self.newScore = newScore
        self.previousLevel = previousLevel
        self.playNextLevel = playNextLevel
    }
}


// MARK: - View Model
extension LevelResultsDataModel {
    var completedLevel: Bool { newScore != nil }
    var titleText: String { "Level \(previousLevel) complete" }
    var playAgainText: String { completedLevel ? "Level \(previousLevel + 1)" : "Try again?" }
    
    func updateScore() {
        if let newScore = newScore {
            currentScore = newScore
        } else {
            showingGameOver = true
        }
    }
}
