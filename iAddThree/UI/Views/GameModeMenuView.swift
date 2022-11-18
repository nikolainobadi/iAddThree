//
//  GameModeMenuView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import SwiftUI

struct GameModeMenuView: View {
    @StateObject var dataModel: GameModeMenuDataModel
    
    let startGame: () -> Void
    let showInstructions: () -> Void
    
    private var highScore: Int { dataModel.highScore }
    private var showFooter: Bool { highScore > 0 }
    private func resetScore() { dataModel.resetHighScore() }
    
    var body: some View {
        VStack {
            ChalkButton("Start Game", style: .title2, action: startGame)
            ChalkButton("How to Play", style: .subheadline, action: showInstructions)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .canShowError(error: $dataModel.error, doneAction: { dataModel.error = nil })
        .overlay(GameModeMenuFooter(highScore: highScore, shouldShow: showFooter, resetScore: resetScore).padding(), alignment: .bottom)
    }
}


// MARK: - Footer
fileprivate struct GameModeMenuFooter: View {
    @State private var showingConfirmation = false
    
    let highScore: Int
    let shouldShow: Bool
    let resetScore: () -> Void
    
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
        .opacity(shouldShow ? 1 : 0)
        .confirmationDialog("", isPresented: $showingConfirmation) {
            Button(role: .destructive, action: resetScore) { Text("Reset High Score") }
        } message: {
            Text("When you reset your high score, your current score will also be reset. Would you like to proceed?")
        }
    }
}


// MARK: - Preview
struct GameModeMenuView_Previews: PreviewProvider {
    static var resetHandler: ScoreResetHandler { ScoreManager(highScoreStore: SinglePlayHighScoreStore(), levelScoreStore: GameContentViewDataModel()) }

    static func makeDataModel(_ highScore: Int = 0) -> GameModeMenuDataModel { GameModeMenuDataModel(resetHandler: resetHandler, highScore: highScore) }
    
    static var previews: some View {
        GameModeMenuView(dataModel: makeDataModel(), startGame: { }, showInstructions: { })
            .onChalkboard()
    }
}
