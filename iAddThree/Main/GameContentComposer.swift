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
        let resetHandler = ScoreManager(highScoreStore: highScoreStore, levelScoreStore: scoreStore)
        let dataModel = GameModeMenuDataModel(resetHandler: resetHandler, highScore: highScoreStore.highScore)
        
        return GameModeMenuView(dataModel: dataModel, startGame: startGame, showInstructions: showInstructions)
    }
    
    static func makeInstructionsView(_ mode: GameMode) -> some View {
        InstructionsView(dataModel: InstructionsDataModel(mode: mode, instructionsList: InstructionsFactory.makeInstructions(for: mode)))
    }
    
    static func makePlayView(mode: GameMode, scoreStore: LevelScoreStore, showResults: @escaping (LevelResults) -> Void) -> some View {
        let numberList = NumberItemFactory.makeNumberList(mode)
        let highScoreStore = UserDefaultsHighScoreStore(mode: mode)
        let info = LevelInfo(score: scoreStore.score, level: scoreStore.level, highScore: highScoreStore.highScore)
        let updater = ScoreManager(highScoreStore: highScoreStore, levelScoreStore: scoreStore)
        let dataModel = PlayViewDataModel(numberList: numberList, info: info, updater: updater, showResults: showResults)
        
        return PlayView(dataModel: dataModel)
    }
    
    static func makeResultsView(results: LevelResults, playAgain: @escaping () -> Void) -> some View {
        return LevelResultsView(dataModel: LevelResultsDataModel(results: results, playAgain: playAgain))
    }
}
