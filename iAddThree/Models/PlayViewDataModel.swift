//
//  PlayViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

final class PlayViewDataModel {
    var numberList: [NumberItemPresenter]
    
    private let finished: (Int) -> Void
    
    init(numberList: [NumberItemPresenter], finished: @escaping (Int) -> Void) {
        self.numberList = numberList
        self.finished = finished
    }
}


// MARK: - Actions
extension PlayViewDataModel {
    func submitAnswer(_ number: String) {
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            addAnswer(answer: number, at: index)
        }
    }
}


// MARK: - Private
private extension PlayViewDataModel {
    private var pointsToAdd: Int { numberList.filter({ $0.isCorrect }).count }
    private var canSubmitAnswer: Bool { !numberList.filter({ $0.userAnswer == nil }).isEmpty }
    
    func addAnswer(answer: String, at index: Int) {
        numberList[index].userAnswer = answer
        
        if !canSubmitAnswer {
            finished(pointsToAdd)
        }
    }
}
