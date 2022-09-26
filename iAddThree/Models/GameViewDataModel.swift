//
//  GameViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class GameViewDataModel: ObservableObject {
    @Published var numberList = [NumberItemPresenter]()
    
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
    var scoreText: String { "Score: \(store.score)" }
    var highScoreText: String { "High Score: \(store.highScore)" }
    var modeTitle: String { mode.title }
    var allAnswersFilled: Bool { numberList.filter({ $0.userAnswer == nil }).isEmpty }
    
    func setNewNumberlist() { numberList = makeNumberList() }
    func submitAnswer(_ number: String) {
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            numberList[index].userAnswer = number
        }
    }
    
    func loadResults() async throws -> LevelResultInfo {
        let points = pointsToAdd
        return try await store.loadResults(pointsToAdd: points)
    }
}


// MARK: - Private Methods
private extension GameViewDataModel {
    var pointsToAdd: Int { numberList.filter({ $0.isCorrect }).count }
    
    func makeNumberList() -> [NumberItemPresenter] { NumberItemFactory.makeNumberList(mode).map({ NumberItemPresenter($0) }) }
}


// MARK: - Dependencies
protocol GameStore {
    var score: Int { get }
    var level: Int { get }
    var highScore: Int { get }
    
    func loadResults(pointsToAdd: Int) async throws -> LevelResultInfo
}

extension GameMode {
    var title: String {
        switch self {
        case .add: return "Add Three"
        }
    }
}
