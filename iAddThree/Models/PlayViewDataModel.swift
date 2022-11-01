//
//  PlayViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import Foundation

final class PlayViewDataModel: ObservableObject {
    @Published var numberList: [NumberItemPresenter]
    
    private let store: GameStore
    private let showResults: (LevelResultInfo) -> Void
    
    init(numberList: [NumberItem], store: GameStore, showResults: @escaping (LevelResultInfo) -> Void) {
        self.store = store
        self.showResults = showResults
        self.numberList = numberList.map({ NumberItemPresenter($0) })
    }
    
    // MARK: - TODO
    // when allAnswersFilled || timerUp, should show resultBanner, then call showResults
}


// MARK: - ViewModel
extension PlayViewDataModel {
    var score: Int { store.score }
    var level: Int { store.level }
    var highScore: Int { store.highScore }
    
    func submitNumber(_ number: String) {
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            numberList[index].userAnswer = number
        }
    }
}
