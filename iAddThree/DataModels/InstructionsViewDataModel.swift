//
//  InstructionsViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import Foundation

final class InstructionsDataModel: ObservableObject {
    @Published var currentPage = 0

    private let mode: GameMode
    
    init(mode: GameMode) {
        self.mode = mode
    }
}


// MARK: - View Model
extension InstructionsDataModel {
    var modeTitle: String { mode.title }
    var sampleList: [NumberItemPresenter] { instructionsList[currentPage].sampleNumberList }
    var instructions: String { currentDetails.details }
    var showHowToTitle: Bool { isFirstPage }
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


// MARK: - Private Helpers
private extension InstructionsDataModel {
    var instructionsList: [InstructionDetails] { mode.instructionsList }
    var currentDetails: InstructionDetails { instructionsList[currentPage] }
    var hasMultiplePages: Bool { instructionsList.count > 1 }
    var isFirstPage: Bool { currentPage == 0 }
    var isLastPage: Bool { hasMultiplePages && currentPage == instructionsList.count - 1 }
}


// MARK: - Dependencies
extension GameMode {
    var instructionsList: [InstructionDetails] {
        switch self {
        case .add: return AddInstructionsFactory.makeInstructions()
        case .subtract:
            // MARK: - TODO
            return []
        }
    }
}
