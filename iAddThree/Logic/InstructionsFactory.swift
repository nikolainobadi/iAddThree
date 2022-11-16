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


// MARK: - Private Variables
private extension InstructionsFactory {
    static var sampleNumberList: [NumberItemPresenter] { NumberItemPresenter.defaultList }
}


// MARK: - Private Factory Methods
private extension InstructionsFactory {
    static func makeFirstPage(_ mode: GameMode) -> InstructionDetails {
        InstructionDetails(id: 0, sampleNumberList: sampleNumberList, details: makeFirstPageDetails(mode))
    }
    
    static func makeSecondPage(_ mode: GameMode) -> InstructionDetails {
        let answers = makeSampleAnswers(mode)
        let sampleList = addUserAnswers([answers[0], answers[1]], to: sampleNumberList)
        
        return InstructionDetails(id: 1, sampleNumberList: sampleList, details:
               """
               When you answer correctly, the correct number will appear in green.

               However, if you are incorrect, the number will appear in red.
               """
        )
    }
    
    static func makeThirdPage(_ mode: GameMode) -> InstructionDetails {
        InstructionDetails(id: 2, sampleNumberList: [], details: makeThirdPageDetails(mode))
    }
}


// MARK: - Private Helper Methods
private extension InstructionsFactory {
    static func getOperator(_ mode: GameMode) -> String { mode == .add ? "+" : "-" }
    
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
            
            "Starting at \(startingNumber), simply move 3 spaces to the \(direction), which makes the correct answer \(correctAnswer).

            """
    }
    
    static func makeSampleAnswers(_ mode: GameMode) -> [String] {
        switch mode {
        case .add: return ["8", "2", "1", "0"]
        case .subtract: return ["", "", "", ""]
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

//class BaseInstructionsFactory {
//    static let sampleNumberList: [NumberItemPresenter] = NumberItemPresenter.defaultList
//
//    static func makeUserAnsers(_ one: String, _ two: String? = nil, _ three: String? = nil, _ four: String? = nil) -> [String?] {
//        [one, two, three, four]
//    }
//
//    static func addUserAnswers(_ answers: [String?], to list: [NumberItemPresenter]) -> [NumberItemPresenter] {
//        zip(list, answers).map { item, userAnswer in
//            var updated = item
//            updated.userAnswer = userAnswer
//            return updated
//        }
//    }
//}

// MARK: - AddInstructions
//final class AddInstructionsFactory: BaseInstructionsFactory {
//    private override init() { super.init() }
//
//    static func makeInstructions() -> [InstructionDetails] { [firstPage, secondPage, thirdPage] }
//    
//    private static var firstPage: InstructionDetails {
//        InstructionDetails(id: 0, sampleNumberList: sampleNumberList, details:
//        """
//        Four random numbers will appear at the beginning of each round.
//
//        Add '3' to each number, starting on the left and making your way to the right.
//        """
//        )
//    }
//
//    private static var secondPage: InstructionDetails {
//        InstructionDetails(id: 1, sampleNumberList: addUserAnswers(makeUserAnsers("8", "2"), to: sampleNumberList), details:
//        """
//        When you answer correctly, the correct number will appear in green.
//
//        However, if you are incorrect, the number will appear in red.
//        """
//        )
//    }
//
//    private static var thirdPage: InstructionDetails {
//        InstructionDetails(id: 2, sampleNumberList: addUserAnswers(makeUserAnsers("8", "2", "1", "0"), to: sampleNumberList), details:
//        """
//        If the correct answer should be greater than '9', simply drop the tenths place ('drop the one')
//
//        Examples:
//        7+3 = '10', answer is '0'
//        8+3 = '11', answer is '1'
//        9+3 = '12', answer is '2'
//        """
//        )
//    }
//}


// MARK: - Subtract Instructions
//final class SubtractInstructionsFactory: BaseInstructionsFactory {
//    private override init() { super.init() }
//
//    static func makeInstructions() -> [InstructionDetails] { [firstPage, secondPage, thirdPage] }
//
//    private static var firstPage: InstructionDetails {
//        InstructionDetails(id: 0, sampleNumberList: sampleNumberList, details:
//        """
//        Four random numbers will appear at the beginning of each round.
//
//        Add '3' to each number, starting on the left and making your way to the right.
//        """
//        )
//    }
//
//    private static var secondPage: InstructionDetails {
//        InstructionDetails(id: 1, sampleNumberList: addUserAnswers(makeUserAnsers("8", "2"), to: sampleNumberList), details:
//        """
//        When you answer correctly, the correct number will appear in green.
//
//        However, if you are incorrect, the number will appear in red.
//        """
//        )
//    }
//
//    private static var thirdPage: InstructionDetails {
//        InstructionDetails(id: 2, sampleNumberList: addUserAnswers(makeUserAnsers("8", "2", "1", "0"), to: sampleNumberList), details:
//        """
//        If the correct answer should be greater than '9', simply drop the tenths place ('drop the one')
//
//        Examples:
//        7+3 = '10', answer is '0'
//        8+3 = '11', answer is '1'
//        9+3 = '12', answer is '2'
//        """
//        )
//    }
//}


// MARK: - Dependencies
extension NumberItem {
    static var defaultList: [NumberItem] {
        [
            NumberItem(number: 5, answer: 8),
            NumberItem(number: 0, answer: 3),
            NumberItem(number: 8, answer: 1),
            NumberItem(number: 7, answer: 0)
        ]
    }
}

extension NumberItemPresenter {
    static var defaultList: [NumberItemPresenter] {
        NumberItem.defaultList.map({ NumberItemPresenter($0) })
    }
}
