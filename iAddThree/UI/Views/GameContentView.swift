//
//  GameContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 10/31/22.
//

import SwiftUI

struct GameContentView: View {
    @Binding var state: GameState
    @State private var showingInstructions = false
    @StateObject private var dataModel = GameContentViewDataModel()
    
    let mode: GameMode
    
    private func playAgain() {
        state = .playing
    }
    
    var body: some View {
        VStack {
            switch state {
            case .menu:
                GameContentComposer.makeMenuView(mode: mode, scoreStore: dataModel, startGame: { state = .playing }, showInstructions: { showingInstructions = true })
                    .transition(.scale)
            case .playing:
                GameContentComposer.makePlayView(mode: mode, scoreStore: dataModel, showResults: { state = .results($0) })
                    .transition(.scale)
            case .results(let results):
                GameContentComposer.makeResultsView(results: results, playAgain: playAgain)
            }
        }.sheet(isPresented: $showingInstructions) { GameContentComposer.makeInstructionsView(mode) }
    }
}


// MARK: - Preview
struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameContentView(state: .constant(.menu), mode: .add)
            .onChalkboard()
    }
}
