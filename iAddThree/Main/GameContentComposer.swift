//
//  GameContentComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import SwiftUI
import Foundation

enum GameContentComposer {
    static func makeMenuView(mode: GameMode, scoreStore: LevelScoreStore, startGame: @escaping () -> Void, showInstructions: @escaping () -> Void) -> some View {
        let highScoreStore = UserDefaultsHighScoreStore(mode: mode)
        let updater = ScoreManager(highScoreStore: highScoreStore, levelScoreStore: scoreStore)
        let dataModel = GameModeMenuDataModel(updater: updater, highScore: highScoreStore.highScore)
        
        return GameModeMenuView(dataModel: dataModel, startGame: startGame, showInstructions: showInstructions)
    }
    
    static func makeInstructionsView(_ mode: GameMode) -> some View {
        InstructionsView(dataModel: InstructionsDataModel(mode: mode))
    }
    
    static func makePlayView(mode: GameMode, scoreStore: LevelScoreStore, showResults: @escaping (LevelResultInfo) -> Void) -> some View {
        let numberList = NumberItemFactory.makeNumberList(mode)
        let store = UserDefaultsHighScoreStore(mode: mode)
        let manager = GameStorageManager(store: store)
        let dataModel = PlayViewDataModel(numberList: numberList, store: manager, showResults: showResults)
        
        return PlayView(dataModel: dataModel)
    }
    
    static func makeResultsView(results: LevelResultInfo, playAgain: @escaping () -> Void) -> some View {
        return ResultsView(dataModel: ResultsDataModel(results: results, playAgain: playAgain))
    }
}
