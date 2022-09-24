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
    
    private var showNextButton: Bool { dataModel.showNextButton }
    private var showPreviousButton: Bool { dataModel.showPreviousButton }
    
    private func turnPage(backwards: Bool = false) {
        withAnimation { dataModel.turnPage(backwards: backwards) }
    }
    
    var body: some View {
        VStack {
            NumberListView(list: dataModel.sampleList)
            
            VStack {
                Text(dataModel.instructions)
                    .setSmoothFont(.subheadline, autoSize: true)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .padding([.horizontal])
                
                HStack {
                    ToolBarButton(text: "Previews", color: .red, isShowing: showPreviousButton, action: { turnPage(backwards: true) })
                    Spacer()
                    ToolBarButton(text: "Next", color: .green, isShowing: showNextButton, action: { turnPage() })
                }.padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(.black.opacity(0.5))
            .cornerRadius(20)
            .padding()
        }.onChalkboard()
    }
}


// MARK: - ToolBarButton
fileprivate struct ToolBarButton: View {
    let text: String
    let color: Color
    let isShowing: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action, label: {
            Text(text)
                .underline()
                .setSmoothFont(.title3, textColor: color)
        }).opacity(isShowing ? 1 : 0)
    }
}


// MARK: - Previews
struct InstructionsView_Previews: PreviewProvider {
    static func makeDataModel(_ mode: GameMode = .add) -> InstructionsDataModel {
        InstructionsDataModel(mode: mode)
    }
    
    static var previews: some View {
        InstructionsView(dataModel: makeDataModel())
    }
}


// MARK: - DataModel
final class InstructionsDataModel: ObservableObject {
    @Published var currentPage = 0

    private let mode: GameMode
    
    init(mode: GameMode) {
        self.mode = mode
    }
}

extension InstructionsDataModel {
    var modeTitle: String { mode.title }
    var sampleList: [NumberItemPresenter] { instructionsList[currentPage].sampleNumberList }
    var instructions: String { currentDetails.details }
    var showPreviousButton: Bool { hasMultiplePages && !isFirstPage }
    var showNextButton: Bool { hasMultiplePages && !isLastPage }
    
    func turnPage(backwards: Bool) {
        if backwards {
            if !isFirstPage { currentPage -= 1 }
        } else {
            if !isLastPage { currentPage += 1 }
        }
    }
}

private extension InstructionsDataModel {
    var instructionsList: [InstructionDetails] { mode.instructionsList }
    var currentDetails: InstructionDetails { instructionsList[currentPage] }
    var hasMultiplePages: Bool { instructionsList.count > 1 }
    var isFirstPage: Bool { currentPage == 0 }
    var isLastPage: Bool { hasMultiplePages && currentPage == instructionsList.count - 1 }
}


// MARK: - GameMode Extension
extension GameMode {
    var instructionsList: [InstructionDetails] {
        switch self {
        case .add: return AddInstructionsFactory.makeInstructions()
        }
    }
}


// MARK: - Instructions Factory
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

