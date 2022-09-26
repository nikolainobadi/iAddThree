//
//  SinglePlayHighScoreStore.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class SinglePlayHighScoreStore: HighScoreStore {
    var highScore: Int = 0
    
    func saveHighScore(_ newHighScore: Int) async throws { highScore = newHighScore }
    func resetHighScore() async throws { highScore = 0 }
}
