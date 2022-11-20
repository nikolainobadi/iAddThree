//
//  GameContentComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import SwiftUI
import Foundation

enum GameContentComposer {
    static func makeGameContentView(state: Binding<GameState>, mode: GameMode) -> some View {
        let dataModel = GameContentViewDataModel()
        
        return GameContentView(state: state, dataModel: dataModel, mode: mode)
    }
    
    static func makeMenuView(mode: GameMode, scoreStore: LevelScoreStore, startGame: @escaping () -> Void, showInstructions: @escaping () -> Void) -> some View {
        let highScoreStore = UserDefaultsHighScoreStore(mode: mode)
        let resetHandler = ScoreManager(highScoreStore: highScoreStore, levelScoreStore: scoreStore)
        let dataModel = GameModeMenuDataModel(resetHandler: resetHandler, highScore: highScoreStore.highScore)
        let adLoader = makeAdLoader(level: scoreStore.level, completion: startGame)
        
        return GameModeMenuView(dataModel: dataModel, startGame: adLoader.showAd, showInstructions: showInstructions)
    }
    
    static func makeInstructionsView(_ mode: GameMode) -> some View {
        InstructionsView(dataModel: InstructionsDataModel(mode: mode, instructionsList: InstructionsFactory.makeInstructions(for: mode)))
    }
    
    static func makePlayView(mode: GameMode, scoreStore: LevelScoreStore, withAds: Bool, showResults: @escaping (LevelResults) -> Void) -> some View {
        let numberList = NumberItemFactory.makeNumberList(mode)
        let highScoreStore = UserDefaultsHighScoreStore(mode: mode)
        let highScoreDecorator = ModeLevelHighScoreStoreDecorator(mode: mode, decoratee: highScoreStore)
        let info = LevelInfo(score: scoreStore.score, level: scoreStore.level, highScore: highScoreStore.highScore)
        let updater = ScoreManager(highScoreStore: highScoreDecorator, levelScoreStore: scoreStore)
        let dataModel = PlayViewDataModel(numberList: numberList, info: info, updater: updater, showResults: showResults)
        
        return PlayView(dataModel: dataModel)
    }
    
    static func makeResultsView(results: LevelResults, withAds: Bool, playAgain: @escaping () -> Void) -> some View {
        let adLoader = makeAdLoader(level: results.currentLevel + 1, completion: playAgain)
        let dataModel = LevelResultsDataModel(results: results, playAgain: adLoader.showAd)
        
        return LevelResultsView(dataModel: dataModel)
    }
}


// MARK: - Private Methods
private extension GameContentComposer {
    static func makeAdLoader(level: Int, completion: @escaping () -> Void) -> InterstitialAdLoader {
        AdMobComposer.makeInterstitialLoader(shouldShowAd: AdDisplayManager(level: level).shouldShowAdd(), completion: completion)
    }
}



// MARK: - Dependencies
final class AdDisplayManager {
    private let level: Int
    
    init(level: Int) {
        self.level = level
    }
    func shouldShowAdd() -> Bool {
        level % 3 == 0
    }
}
