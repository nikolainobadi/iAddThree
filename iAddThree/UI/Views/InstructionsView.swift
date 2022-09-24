//
//  InstructionsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: InstructionsDataModel
    
    var body: some View {
        VStack {
            
        }.onChalkboard()
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static func makeDataModel(_ mode: GameMode = .add) -> InstructionsDataModel {
        InstructionsDataModel(instructionsList: mode.instructionsList)
    }
    
    static var previews: some View {
        InstructionsView(dataModel: makeDataModel())
    }
}

final class InstructionsDataModel: ObservableObject {
    private let instructionsList: [InstructionDetails]
    
    init(instructionsList: [InstructionDetails]) {
        self.instructionsList = instructionsList
    }
}

extension InstructionsDataModel {
    
}

extension GameMode {
    var instructionsList: [InstructionDetails] {
        switch self {
        case .add: return AddInstructionsFactory.makeInstructions()
        }
    }
}

class BaseInstructionsFactory {
    static let sampleNumberList: [NumberItemPresenter] = NumberItemPresenter.defaultList
    
    static func makeUserAnsers(_ one: String, _ two: String? = nil, _ three: String? = nil, _ four: String? = nil) -> [String?] {
        [one, two, three, four]
    }
    
    static func addUserAnswers(_ answers: [String?], to list: [NumberItemPresenter]) -> [NumberItemPresenter] {
        zip(list, answers).map { item, userAnswer in
            var updated = item
            updated.userAnswer = userAnswer
            return updated
        }
    }
}

// MARK: - AddInstructions
final class AddInstructionsFactory: BaseInstructionsFactory {
    private override init() { super.init() }

    static func makeInstructions() -> [InstructionDetails] { [firstPage, secondPage, thirdPage] }
}

private extension AddInstructionsFactory {
    static var firstPage: InstructionDetails {
        InstructionDetails(id: 0, sampleNumberList: sampleNumberList, details:
        """
        Four random numbers will appear at the beginning of each round.

        Add '3' to each number, starting on the left and making your way to the right.
        """
        )
    }

    static var secondPage: InstructionDetails {
        InstructionDetails(id: 1, sampleNumberList: addUserAnswers(makeUserAnsers("8", "2"), to: sampleNumberList), details:
        """
        When you answer correctly, the correct number will appear in green.

        However, if you are incorrect, the number will appear in red.
        """
        )
    }

    static var thirdPage: InstructionDetails {
        InstructionDetails(id: 2, sampleNumberList: addUserAnswers(makeUserAnsers("8", "2", "1", "0"), to: sampleNumberList), details:
        """
        If the correct answer should be greater than '9', simply drop the tenths place ('drop the one')

        Examples:
        7+3 = '10', answer is '0'
        8+3 = '11', answer is '1'
        9+3 = '12', answer is '2'
        """
        )
    }
}

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

