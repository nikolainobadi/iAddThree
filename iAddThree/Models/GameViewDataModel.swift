//
//  GameViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class GameViewDataModel: ObservableObject {
    @Published var timerActive = false
    @Published var numberList = [NumberItemPresenter]()
    @Published var timeRemaining: Float = 10
    @Published var results: LevelResultInfo?
    @Published var error: Error?

    private let mode: GameMode
    private let store: GameStore
    
    init(mode: GameMode, store: GameStore = GameStorageManager()) {
        self.mode = mode
        self.store = store
    }
}


// MARK: - View Model
extension GameViewDataModel {
    var level: Int { store.level }
    var modeTitle: String { mode.title }
    var scoreText: String { "Score: \(store.score)" }
    var canResetHighScore: Bool { store.highScore > 0 }
    var highScoreText: String { "High Score: \(store.highScore)" }
    var allAnswersFilled: Bool { numberList.filter({ $0.userAnswer == nil }).isEmpty }
    
    func startNextLevel() {
        configureTimer()
        numberList = makeNumberList()
    }
    
    func submitAnswer(_ number: String) {
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            numberList[index].userAnswer = number
        }
    }
    
    func finishLevel() {
        Task {
            do {
                if timerActive {
                    await stopTimer()
                    try? await Task.sleep(nanoseconds: 0_300_000_000)
                }
                
                await postResults(try await store.loadResults(pointsToAdd: pointsToAdd))
            } catch {
                self.error = error
            }
        }
    }
    
    func resetHighScore() {
        Task {
            do {
                try await store.resetHighScore()
            } catch {
                self.error = error
            }
        }
        
    }
}


// MARK: - Private Methods
private extension GameViewDataModel {
    @MainActor func stopTimer() { timerActive = false }
    @MainActor func postResults(_ results: LevelResultInfo) { self.results = results }
    
    var pointsToAdd: Int { numberList.filter({ $0.isCorrect }).count }
    
    func makeNumberList() -> [NumberItemPresenter] { NumberItemFactory.makeNumberList(mode).map({ NumberItemPresenter($0) }) }
    func configureTimer() {
        if level > 1 {
            timeRemaining = TimerManager.makeStartTime(for: level)
            timerActive = true
        }
    }
}


// MARK: - Dependencies
protocol GameStore {
    var score: Int { get }
    var level: Int { get }
    var highScore: Int { get }
    
    func loadResults(pointsToAdd: Int) async throws -> LevelResultInfo
    func resetHighScore() async throws
}

extension GameMode {
    var title: String {
        switch self {
        case .add: return "Add Three"
        }
    }
}
