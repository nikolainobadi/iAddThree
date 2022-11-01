//
//  GameContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 10/31/22.
//

import SwiftUI

enum GameContentComposer {
    static func makeMenuView(mode: GameMode, startGame: @escaping () -> Void, showInstructions: @escaping () -> Void) -> some View {
        let store = UserDefaultsHighScoreStore(mode: .add)
        let dataModel = GameModeMenuDataModel(store: store)
        
        return GameModeMenuView(dataModel: dataModel, startGame: startGame, showInstructions: showInstructions)
    }
    
    static func makeInstructionsView(_ mode: GameMode) -> some View {
        InstructionsView(dataModel: InstructionsDataModel(mode: mode))
    }
    
    static func makePlayView(mode: GameMode, showResults: @escaping (LevelResultInfo) -> Void) -> some View {
        let numberList = NumberItemFactory.makeNumberList(mode)
        let store = UserDefaultsHighScoreStore(mode: mode)
        let manager = GameStorageManager(store: store)
        let dataModel = PlayViewDataModel(numberList: numberList, store: manager, showResults: showResults)
        
        return PlayView(dataModel: dataModel)
    }
    
    static func makeResultsView(info: LevelResultInfo, playAgain: @escaping () -> Void) -> some View {
        EmptyView()
    }
}


struct GameContentView: View {
    @Binding var state: GameState
    @State private var showingInstructions = false
    
    let mode: GameMode
    
    var body: some View {
        VStack {
            switch state {
            case .menu:
                GameContentComposer.makeMenuView(mode: mode, startGame: { state = .playing }, showInstructions: { showingInstructions = true })
                    .transition(.scale)
            case .playing:
                GameContentComposer.makePlayView(mode: mode, showResults: { state = .results($0) })
                    .transition(.scale)
            case .results(let info):
                GameContentComposer.makeResultsView(info: info, playAgain: { state = .playing })
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .sheet(isPresented: $showingInstructions) { GameContentComposer.makeInstructionsView(mode) }
    }
}


// MARK: - Results
fileprivate struct ResultsView: View {
    let results: LevelResultInfo
    let playAgain: () -> Void
    
    var body: some View {
        VStack {
            
        }
    }
}



struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameContentView(state: .constant(.menu), mode: .add)
    }
}
