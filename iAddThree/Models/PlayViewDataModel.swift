//
//  PlayViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import Combine
import Foundation

final class PlayViewDataModel: ObservableObject {
    @Published var error: Error?
    @Published var timerActive = false
    @Published var timeRemaining: Float = 10
    @Published var results: LevelResultInfo?
    @Published var numberList: [NumberItemPresenter]
    
    private let store: GameStore
    
    private var changes = Set<AnyCancellable>()
    
    init(numberList: [NumberItem], store: GameStore, showResults: @escaping (LevelResultInfo) -> Void) {
        self.store = store
        self.numberList = numberList.map({ NumberItemPresenter($0) })
        self.startObservers(showResults: showResults)
    }
}


// MARK: - ViewModel
extension PlayViewDataModel {
    var score: Int { store.score }
    var level: Int { 2 }
    var highScore: Int { store.highScore }
    
    func startLevel() {
        if level > 1 {
            timeRemaining = TimerManager.makeStartTime(for: level)
            timerActive = true
        }
    }
    
    func submitNumber(_ number: String) {
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            numberList[index].userAnswer = number
            
            if allAnswersFilled {
                finishLevel()
            }
        }
    }
}


// MARK: - Private
private extension PlayViewDataModel {
    var pointsToAdd: Int { numberList.filter({ $0.isCorrect }).count }
    var allAnswersFilled: Bool { !numberList.isEmpty && numberList.filter({ $0.userAnswer == nil }).isEmpty }
    
    func finishLevel(timerFinished: Bool = false) {
        if timerFinished {
            timerActive = false
        }
        
        Task {
            do {
                results = try await store.loadResults(pointsToAdd: pointsToAdd)
            } catch {
                self.error = error
            }
        }
    }
    
    func startObservers(showResults: @escaping (LevelResultInfo) -> Void) {
        $results
            .compactMap { $0 }
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .sink { showResults($0) }
            .store(in: &changes)
        
        $timeRemaining
            .drop(while: { $0 > 0 })
            .sink { [weak self] _ in self?.finishLevel() }
            .store(in: &changes)
    }
}
