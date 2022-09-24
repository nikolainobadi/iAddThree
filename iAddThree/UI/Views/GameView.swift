//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct GameView: View {
    @State private var error: Error?
    @State private var isPlaying = false
    @State private var showingInstructions = false
    @State private var results: LevelResultInfo?
    @StateObject var dataModel: GameViewDataModel
    
    private func startGame() { isPlaying = true }
    private func startNextLevel() { results = nil }
    private func finishLevel(_ pointsToAdd: Int) {
        Task {
            try? await Task.sleep(nanoseconds: 0_500_000_000)
            do {
                let results = try await dataModel.loadResults(pointsToAdd)
                
                withAnimation(.easeOut(duration: 0.75)) { self.results = results }
            } catch {
                self.error = error
            }
        }
    }
    
    var body: some View {
        VStack {
            GameTitle(title: dataModel.modeTitle, isPlaying: isPlaying)
            
            if let results = results {
                GameViewComposer.makeLevelResultsView(results: results, playNextLevel: startNextLevel)
                    .transition(.opacity)
            } else {
                VStack {
                    Spacer()
                    if isPlaying {
                        GameViewComposer.makePlayView(.add, finished: finishLevel(_:))
                            .transition(.scale)
                    } else {
                        MenuButtons(isPlaying: isPlaying, startGame: startGame, showInstructions: { showingInstructions = true })
                    }
                    Spacer()
                }.animation(.easeInOut(duration: 0.75), value: isPlaying)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .canShowError(error: $error, doneAction: { error = nil })
        .sheet(isPresented: $showingInstructions) { GameViewComposer.makeInstructionsView(.add) }
        .overlay(
            ScoreView(scoreText: dataModel.scoreText, highScoreText: dataModel.highScoreText)
                .opacity((isPlaying && results == nil) ? 1 : 0)
                .padding()
            , alignment: .bottomLeading
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
                .offset(y: isPlaying ? 0 : getHeightPercent(6))
        }
        .lineLimit(1)
        .padding()
        .animation(.linear(duration: 0.75), value: isPlaying)
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
        GameViewDataModel(mode: mode)
    }
    
    static var previews: some View {
        GameView(dataModel: makeDataModel()).onChalkboard()
    }
}
