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
    @StateObject var dataModel: GameContentViewDataModel
    @AppStorage(AppStorageKey.adsRemoved) var removeAds: Bool = false
    
    let mode: GameMode
    
    var body: some View {
        VStack {
            switch state {
            case .menu:
                GameContentComposer.makeMenuView(mode: mode, scoreStore: dataModel, withAds: !removeAds, startGame: { state = .playing }, showInstructions: { showingInstructions = true })
                    .transition(.scale)
            case .playing:
                GameContentComposer.makePlayView(mode: mode, scoreStore: dataModel, showResults: { state = .results($0) })
                    .transition(.scale)
            case .results(let results):
                GameContentComposer.makeResultsView(results: results, withAds: !removeAds, playAgain: { state = .playing })
            }
        }.sheet(isPresented: $showingInstructions) { GameContentComposer.makeInstructionsView(mode) }
    }
}


// MARK: - Preview
struct GameContentView_Previews: PreviewProvider {
    static var dataModel: GameContentViewDataModel { GameContentViewDataModel( )}
    static var previews: some View {
        GameContentView(state: .constant(.menu), dataModel: dataModel, mode: .add)
            .onChalkboard()
    }
}
