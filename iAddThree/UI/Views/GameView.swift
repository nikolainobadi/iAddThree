//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct GameView: View {
    @State private var isPlaying = false
    @State private var showingInstructions = false
    @StateObject var dataModel: GameViewDataModel
    
    private func startGame() { isPlaying = true }
    private func finishLevel(_ pointsToAdd: Int) { }
    
    var body: some View {
        VStack {
            GameTitle(title: dataModel.modeTitle, isPlaying: isPlaying)
                
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
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .sheet(isPresented: $showingInstructions) { GameViewComposer.makeInstructionsView(.add) }
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


// MARK: - Preview
struct GameView_Previews: PreviewProvider {
    static func makeDataModel(_ mode: GameMode = .add) -> GameViewDataModel {
        GameViewDataModel(mode: mode)
    }
    
    static var previews: some View {
        GameView(dataModel: makeDataModel()).onChalkboard()
    }
}
