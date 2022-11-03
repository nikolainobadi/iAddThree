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
    @Published var results: LevelResultInfo?
    @Published var numberList: [NumberItemPresenter]
    
    private let store: GameStore
    
    private var changes = Set<AnyCancellable>()
    
    init(numberList: [NumberItem], store: GameStore, showResults: @escaping (LevelResultInfo) -> Void) {
        self.store = store
        self.numberList = numberList.map({ NumberItemPresenter($0) })
        self.$results
            .compactMap { $0 }
            .debounce(for: 1.5, scheduler: RunLoop.main)
            .sink { showResults($0) }
            .store(in: &changes)
    }
}


// MARK: - ViewModel
extension PlayViewDataModel {
    var score: Int { store.score }
    var level: Int { store.level }
    var highScore: Int { store.highScore }
    var startTime: Float { TimerManager.makeStartTime(for: level) }
    var finishedMessage: String? {
        guard let results = results else { return nil }
        
        return "Nice"
    }
    
    func startLevel() {
        if level > 1 {
            timerActive = true
            startTimerObserver()
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
        if !timerFinished {
            timerActive = false
        }
        
        Task {
            do {
                let results = try await store.loadResults(pointsToAdd: pointsToAdd, timerFinished: timerFinished)
                
                await postResults(results)
            } catch {
                await showError(error)
            }
        }
    }
    
    func startTimerObserver() {
        $timerActive
            .dropFirst()
            .sink { [weak self] in self?.timesUp(timerActive: $0) }
            .store(in: &changes)
    }
    
    func timesUp(timerActive: Bool) {
        if !timerActive && !allAnswersFilled {
            finishLevel(timerFinished: true)
        }
    }
}


// MARK: - Private UI Methods
private extension PlayViewDataModel {
    @MainActor func showError(_ error: Error) { self.error = error }
    @MainActor func postResults(_ results: LevelResultInfo) { self.results = results }
}


// MARK: - Dependencies
protocol GameStore {
    var score: Int { get }
    var level: Int { get }
    var highScore: Int { get }
    
    func loadResults(pointsToAdd: Int, timerFinished: Bool) async throws -> LevelResultInfo
}
