//
//  GameViewComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

enum GameViewComposer {
    static func makeLevelResultsView(results: LevelResultInfo, playNextLevel: @escaping () -> Void) -> some View {
        EmptyView()
//        LevelResultsView(dataModel: LevelResultsDataModel(currentScore: results.currentScore, newScore: results.newScore, previousLevel: results.previousLevel, playNextLevel: playNextLevel))
    }
    
    static func makeInstructionsView(_ mode: GameMode) -> some View {
        InstructionsView(dataModel: InstructionsDataModel(mode: mode))
    }
}


//  MARK: - Private Methods
private extension GameViewComposer {
    static func makeItemPresenterList(_ mode: GameMode) -> [NumberItemPresenter] {
        NumberItemFactory.makeNumberList(mode).map({ NumberItemPresenter($0) })
    }
}
