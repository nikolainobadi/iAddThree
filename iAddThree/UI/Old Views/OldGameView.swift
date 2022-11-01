//
//  OldGameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct OldGameView: View {
    @State private var isPlaying = false
    @State private var showingSettings = false
    @State private var showingInstructions = false
    @State private var results: LevelResultInfo?
    @StateObject var dataModel: GameViewDataModel
    
    private func startGame() { isPlaying = true }
    private func stopPlaying() { isPlaying = false; results = nil }
    private func finishLevel() { dataModel.finishLevel() }
    private func playNextLevel() { dataModel.results = nil }
    private func submitAnswer(_ number: String) { withAnimation { dataModel.submitAnswer(number) } }
    private func postResults(_ results: LevelResultInfo?) {
        withAnimation(.easeOut(duration: 1))  {
            self.results = results
        }
    }
    
    var body: some View {
        VStack {
            GameTitle(title: dataModel.modeTitle, isPlaying: isPlaying)
            
            if let results = results {
                GameViewComposer.makeLevelResultsView(results: results, playNextLevel: playNextLevel)
                    .transition(.scale)
            } else {
                VStack {
                    if isPlaying {
                        OldPlayView(numberList: dataModel.numberList, submitAnswer: submitAnswer(_:))
                            .withTimer(isActive: $dataModel.timerActive, startTime: dataModel.timeRemaining, finished: finishLevel)
                            .transition(.scale)
                            .onAppear { dataModel.startNextLevel() }
                    } else {
                        Spacer()
                        MenuButtons(isPlaying: isPlaying, startGame: startGame, showInstructions: { showingInstructions = true })
                        
                        Spacer()
                        
                        HighScoreInfoView(highScoreText: dataModel.highScoreText, canReset: dataModel.canResetHighScore, resetHighScore: dataModel.resetHighScore)
                    }
                }.animation(.easeInOut(duration: 0.75), value: isPlaying)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .canShowError(error: $dataModel.error, doneAction: { dataModel.error = nil })
        .onChange(of: dataModel.allAnswersFilled, perform: { if $0 { finishLevel() } })
        .onChange(of: dataModel.results, perform: { postResults($0) })
        .sheet(isPresented: $showingInstructions) { GameViewComposer.makeInstructionsView(.add) }
        .sheet(isPresented: $showingSettings, content: { SettingsView() })
        .overlay(
            Button(action: stopPlaying, label: { Text("Menu").setChalkFont(.subheadline) })
                .padding(.horizontal)
                .opacity((results != nil || isPlaying) ? 1 : 0)
            , alignment: .topLeading
        )
        .overlay(
            ScoreView(scoreText: dataModel.scoreText, highScoreText: dataModel.highScoreText)
                .opacity((isPlaying && results == nil) ? 1 : 0)
                .padding()
            , alignment: .bottomLeading
        )
        .overlay(
            Button(action: { showingSettings = true }) {
                Image(systemName: "gearshape")
                    .setChalkFont(.subheadline)
                    .opacity((isPlaying || results != nil) ? 0 : 1)
            }.padding()
            , alignment: .topTrailing
        )
    }
}


// MARK: - Title
fileprivate struct GameTitle: View {
    let title: String
    let isPlaying: Bool
    
    var body: some View {
        VStack {
            Text(title).setChalkFont(.largeTitle, autoSize: true)
                .scaleEffect(isPlaying ? 0.75 : 1)
                .offset(y: getHeightPercent(isPlaying ? 2 : 5))
        }
        .lineLimit(1)
        .padding()
        .animation(.linear(duration: 0.75), value: isPlaying)
    }
}


// MARK: - PlayView
fileprivate struct OldPlayView: View {
    let numberList: [NumberItemPresenter]
    let submitAnswer: (String) -> Void
    
    var body: some View {
        VStack {
            NumberListView(list: numberList)
            Spacer()
            NumberPadView(selection: submitAnswer)
                .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(55))
            Spacer()
        }
    }
}


// MARK: - MenuButtons
fileprivate struct MenuButtons: View {
    let isPlaying: Bool
    let startGame: () -> Void
    let showInstructions: () -> Void

    var body: some View {
        VStack {
            ChalkButton("Start Game", style: .title2, action: startGame)
            ChalkButton("How to Play", style: .subheadline, action: showInstructions)
        }
        .transition(.scale)
        .animation(.default, value: isPlaying)
    }
}


// MARK: - HighScore Info
fileprivate struct HighScoreInfoView: View {
    @State private var showingConfirmation = false
    
    let highScoreText: String
    let canReset: Bool
    let resetHighScore: () -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            Text(highScoreText)
                .setSmoothFont(.caption)
            Button(action: { showingConfirmation = true }) {
                Text("Reset High Score")
                    .underline()
                    .setSmoothFont(.subheadline)
            }
        }
        .opacity(canReset ? 1 : 0)
        .confirmationDialog("", isPresented: $showingConfirmation) {
            Button(role: .destructive, action: resetHighScore) {
                Text("Reset High Score")
            }
        } message: {
            Text("When you reset your high score, your current score will also be reset. Would you like to proceed?")
        }
    }
}


// MARK: - Score View
fileprivate struct ScoreView: View {
    let scoreText: String
    let highScoreText: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(scoreText)
            Text(highScoreText)
        }.setChalkFont(.body)
    }
}


// MARK: - Preview
struct GameView_Previews: PreviewProvider {
    static func makeDataModel(_ mode: GameMode = .add) -> GameViewDataModel {
        GameViewDataModel(mode: mode, store: GameStorageManager(store: SinglePlayHighScoreStore()))
    }
    
    static var previews: some View {
        OldGameView(dataModel: makeDataModel()).onChalkboard()
    }
}
