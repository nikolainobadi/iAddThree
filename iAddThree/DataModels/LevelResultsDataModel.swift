//
//  LevelResultsDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import Combine
import Foundation

final class LevelResultsDataModel: ObservableObject {
    @Published var currentScore: Int
    @Published var showingViews = false
    @Published var showingButton = false
    @Published var newScore: Int?
    
    let playAgain: () -> Void
    
    private let results: LevelResults
    private var changes = Set<AnyCancellable>()
    
    init(results: LevelResults, playAgain: @escaping () -> Void) {
        self.results = results
        self.playAgain = playAgain
        self.currentScore = results.currentScore
        
        $showingViews
            .drop(while: { !$0 })
            .debounce(for: completedLevel ? 1 : 2, scheduler: RunLoop.main)
            .sink { [weak self] _ in self?.finishAnimation() }
            .store(in: &changes)
        
        $currentScore
            .dropFirst()
            .debounce(for: 1, scheduler: RunLoop.main)
            .sink { [weak self] _ in self?.showingButton = true }
            .store(in: &changes)
    }
}


// MARK: - ViewModel
extension LevelResultsDataModel {
    var completedLevel: Bool { results.pointsToAdd > 0 }
    var currentLevel: Int { results.currentLevel }
    var nextLevel: Int { results.currentLevel + 1 }
    var playAgainText: String { completedLevel ? "Level \(nextLevel)" : "Try Again?" }
    
    func showResults() { showingViews = true }
}


// MARK: - Private
private extension LevelResultsDataModel {
    func finishAnimation() {
        if completedLevel {
            newScore = currentScore + results.pointsToAdd
        } else {
            showingButton = true
        }
    }
}
