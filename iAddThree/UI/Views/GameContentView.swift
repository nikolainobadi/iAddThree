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


// MARK: - Preview
struct GameContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameContentView(state: .constant(.menu), mode: .add)
    }
}
