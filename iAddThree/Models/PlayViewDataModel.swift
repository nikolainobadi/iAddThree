//
//  PlayViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

final class PlayViewDataModel: ObservableObject {
    @Published var timerActive = false
    @Published var numberList: [NumberItemPresenter]
    
    let remainingTime: Float
    
    private let finished: (Int) -> Void
    
    init(numberList: [NumberItemPresenter], remainingTime: Float,  finished: @escaping (Int) -> Void) {
        self.numberList = numberList
        self.remainingTime = remainingTime
        self.finished = finished
    }
}


// MARK: - Actions
extension PlayViewDataModel {
    func startTimer() { if remainingTime > 0 { timerActive = true } }
    func timerFinished() { finishLevel() }
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
            finishLevel()
        }
    }
    
    func finishLevel() {
        timerActive = false
        finished(pointsToAdd)
    }
}
