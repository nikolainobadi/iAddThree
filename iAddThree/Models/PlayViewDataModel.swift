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
    @Published var results: LevelResults?
    @Published var numberList: [NumberItemPresenter]
    
    private let info: LevelInfo
    private let updater: ScoreUpdater
    
    private var changes = Set<AnyCancellable>()
    
    init(numberList: [NumberItem], info: LevelInfo, updater: ScoreUpdater, showResults: @escaping (LevelResults) -> Void) {
        self.info = info
        self.updater = updater
        self.numberList = numberList.map({ NumberItemPresenter($0) })
        self.$results
            .compactMap { $0 }
            .debounce(for: 2, scheduler: RunLoop.main)
            .sink { showResults($0) }
            .store(in: &changes)
    }
}


// MARK: - ViewModel
extension PlayViewDataModel {
    var score: Int { info.score }
    var level: Int { info.level }
    var highScore: Int { info.highScore }
    var startTime: Float { TimerManager.makeStartTime(for: level) }
    
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
    
    func finishLevel(timerFinished: Bool = false) {
        stopTimer(timerFinished)
        saveProgress(timerFinished)
    }
    
    func stopTimer(_ timerFinished: Bool) {
        if !timerFinished {
            timerActive = false
        }
    }
    
    func saveProgress(_ timerFinished: Bool) {
        Task {
            do {
                let results = try await makeResults(timerFinished)
                
                await postResults(results)
            } catch {
                await showError(error)
            }
        }
    }
    
    func makeResults(_ timerFinished: Bool) async throws -> LevelResults {
        throw NSError()
    }
}


// MARK: - Private UI Methods
private extension PlayViewDataModel {
    @MainActor func showError(_ error: Error) { self.error = error }
    @MainActor func postResults(_ results: LevelResults) { self.results = results }
}


// MARK: - Dependencies
protocol GameStore {
    var score: Int { get }
    var level: Int { get }
    var highScore: Int { get }
    
    func loadResults(pointsToAdd: Int, timerFinished: Bool) async throws -> LevelResults
}
