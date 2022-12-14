//
//  InstructionsFactory.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

enum InstructionsFactory {
    static func makeInstructions(for mode: GameMode) -> [InstructionDetails] {
        [makeFirstPage(mode), makeSecondPage(mode), makeThirdPage(mode)]
    }
}


// MARK: - Private Factory Methods
private extension InstructionsFactory {
    static func makeFirstPage(_ mode: GameMode) -> InstructionDetails {
        InstructionDetails(id: 0, sampleNumberList: makeSampleList(mode), details: makeFirstPageDetails(mode))
    }
    
    static func makeSecondPage(_ mode: GameMode) -> InstructionDetails {
        let answers = makeSampleAnswers(mode)
        let sampleList = addUserAnswers([answers[0], answers[1], nil, nil], to: makeSampleList(mode))
        
        return InstructionDetails(id: 1, sampleNumberList: sampleList, details:
               """
               When you answer correctly, the correct number will appear in green.

               However, if you are incorrect, the number will appear in red.
               """
        )
    }
    
    static func makeThirdPage(_ mode: GameMode) -> InstructionDetails {
        let sampleList = addUserAnswers(makeSampleAnswers(mode), to: makeSampleList(mode))
        
        return InstructionDetails(id: 2, sampleNumberList: sampleList, details: makeThirdPageDetails(mode))
    }
}


// MARK: - Private Helper Methods
private extension InstructionsFactory {
    static func getOperator(_ mode: GameMode) -> String { mode == .add ? "+" : "-" }
    static func makeSampleList(_ mode: GameMode) -> [NumberItemPresenter] {
        switch mode {
        case .add: return NumberItem.defaultAddList.map({ NumberItemPresenter($0) })
        case .subtract: return NumberItem.defaultSubtractList.map({ NumberItemPresenter($0) })
        }
    }
    
    static func makeFirstPageDetails(_ mode: GameMode) -> String {
        """
        Four random numbers will appear at the beginning of each round.

        \(mode == .add ? "Add" : "Subtract") '3' \(mode == .add ? "to" : "from") each number, starting on the left and making your way to the right.
        """
    }
    
    static func makeThirdPageDetails(_ mode: GameMode) -> String {
        let restriction = mode == .add ? "double digits" : "negative"
        let equalityValue = mode ==  .add ? "greater than '9'" : "less than '0'"
        let numberLine = mode == .add ? "7 -> 8 -> 9 -> 0 -> 1 -> 2 -> 3" : "7 <- 8 <- 9 <- 0 <- 1 <- 2 <- 3"
        let equation = mode == .add ? "8+3" : "2-3"
        let startingNumber = mode == .add ? "8" : "2"
        let direction = mode == .add ? "right" : "left"
        let correctAnswer = mode == .add ? "1" : "9"
        
        return """
            Remember, answers CANNOT be \(restriction). If the correct answer should be \(equalityValue), you must wrap around the 0.
            
            Use the following number line as a guide to get the answer for \(equation).
            
            \(numberLine)
            
            Starting at \(startingNumber), simply move 3 spaces to the \(direction), which makes the correct answer \(correctAnswer).

            """
    }
    
    static func makeSampleAnswers(_ mode: GameMode) -> [String] {
        switch mode {
        case .add: return ["8", "2", "1", "0"]
        case .subtract: return ["2", "7", "8", "4"]
        }
    }
    
    static func addUserAnswers(_ answers: [String?], to list: [NumberItemPresenter]) -> [NumberItemPresenter] {
        zip(list, answers).map { item, userAnswer in
            var updated = item
            updated.userAnswer = userAnswer
            return updated
        }
    }
}


// MARK: - Dependencies
extension NumberItem {
    static var defaultAddList: [NumberItem] {
        [
            NumberItem(number: 5, answer: 8),
            NumberItem(number: 0, answer: 3),
            NumberItem(number: 8, answer: 1),
            NumberItem(number: 7, answer: 0)
        ]
    }
    
    static var defaultSubtractList: [NumberItem] {
        [
            NumberItem(number: 5, answer: 2),
            NumberItem(number: 9, answer: 6),
            NumberItem(number: 1, answer: 8),
            NumberItem(number: 7, answer: 4)
        ]
    }
}

extension NumberItemPresenter {
    static var defaultList: [NumberItemPresenter] {
        NumberItem.defaultAddList.map({ NumberItemPresenter($0) })
    }
}
