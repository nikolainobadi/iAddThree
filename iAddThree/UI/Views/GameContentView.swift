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
        
        return GameModeMenu(dataModel: dataModel, startGame: startGame, showInstructions: showInstructions)
    }
    
    static func makeInstructionsView(_ mode: GameMode) -> some View {
        InstructionsView(dataModel: InstructionsDataModel(mode: mode))
    }
    
    static func makePlayView(mode: GameMode, showResults: @escaping (LevelResultInfo) -> Void) -> some View {
        let dataModel = PlayViewDataModel(mode: mode, showResults: showResults)
        
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


// MARK: - Menu
fileprivate struct GameModeMenu: View {
    @State private var showingInstructions = false
    
    let dataModel: GameModeMenuDataModel
    let startGame: () -> Void
    let showInstructions: () -> Void
    
    private var highScore: Int { dataModel.highScore }
    private func resetScore() { dataModel.resetHighScore() }
    
    var body: some View {
        VStack {
            ChalkButton("Start Game", style: .title2, action: startGame)
            ChalkButton("How to Play", style: .subheadline, action: { showingInstructions = true })
        }.overlay(GameModeMenuFooter(highScore: highScore, resetScore: resetScore), alignment: .bottom)
    }
}

fileprivate struct GameModeMenuFooter: View {
    @State private var showingConfirmation = false
    
    let highScore: Int
    let resetScore: () -> Void
    
    private var showHighScore: Bool { highScore > 0 }
    
    var body: some View  {
        VStack(spacing: 0) {
            Text("High Score: \(highScore)")
                .setSmoothFont(.caption)
            Button(action: { showingConfirmation = true }) {
                Text("Reset High Score")
                    .underline()
                    .setSmoothFont(.subheadline)
            }
        }
        .opacity(showHighScore ? 1 : 0)
        .confirmationDialog("", isPresented: $showingConfirmation) {
            Button(role: .destructive, action: resetScore) { Text("Reset High Score") }
        } message: {
            Text("When you reset your high score, your current score will also be reset. Would you like to proceed?")
        }
    }
}

final class GameModeMenuDataModel: ObservableObject {
    private let store: HighScoreStore
    
    init(store: HighScoreStore) {
        self.store = store
    }
}

extension GameModeMenuDataModel {
    var highScore: Int { store.highScore }
    
    func resetHighScore() {
        
    }
}


// MARK: - PlayView
fileprivate struct PlayView: View {
    let dataModel: PlayViewDataModel
    
    private var score: Int { dataModel.score }
    private var highScore: Int { dataModel.highScore }
    
    var body: some View {
        VStack {
            NumberListView(list: dataModel.numberList)
            Spacer()
            NumberPadView(selection: dataModel.submitNumber(_:))
                .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(55))
            Spacer()
        }.overlay(PlayViewFooter(score: score, highScore: highScore).padding(), alignment: .bottomLeading)
    }
}

fileprivate struct PlayViewFooter: View {
    let score: Int
    let highScore: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(score)")
            Text("High Score: \(highScore)")
        }.setChalkFont(.body)
    }
}

final class PlayViewDataModel: ObservableObject {
    @Published var numberList: [NumberItemPresenter]
    
    private let showResults: (LevelResultInfo) -> Void
    
    // MARK: - TODO
    // will need to import scores from separate file
    // score also needs to persist (like highScore)
    // but only highScore is saved to UserDefaults
    
    var score: Int = 0
    var highScore: Int = 0
    
    init(mode: GameMode, showResults: @escaping (LevelResultInfo) -> Void) {
        numberList = NumberItemFactory.makeNumberList(mode).map({ NumberItemPresenter($0) })
        self.showResults = showResults
    }
    
    func submitNumber(_ number: String) {
        if let index = numberList.firstIndex(where: { $0.userAnswer == nil }) {
            numberList[index].userAnswer = number
        }
    }
    
    
    // MARK: - TODO
    // when allAnswersFilled || timerUp, should show resultBanner, then call showResults
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
