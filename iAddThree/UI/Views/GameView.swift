//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct GameView: View {
    @StateObject var dataModel: GameViewDataModel
    
    private var isPlaying: Bool { dataModel.isPlaying }
    
    private func showInstructions() { }
    private func finishLevel(_ pointsToAdd: Int) {}
    
    var body: some View {
        VStack {
            GameTitle(title: dataModel.modeTitle, isPlaying: isPlaying)
                
            VStack {
                Spacer()
                if isPlaying {
                    GameViewComposer.makePlayView(.add, finished: finishLevel(_:))
                        .transition(.scale)
                } else {
                    MenuButtons(isPlaying: isPlaying, startGame: dataModel.startGame, showInstructions: showInstructions)
                }
                Spacer()
            }.animation(.easeInOut(duration: 0.75), value: isPlaying)
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}

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

struct ChalkButton: View {
    let text: String
    let style: Font.TextStyle
    let action: () -> Void
    
    init(_ text: String, style: Font.TextStyle = .title3, action: @escaping () -> Void) {
        self.text = text
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(.horizontal, getWidthPercent(10))
                .lineLimit(1)
                .setChalkFont(style, textColor: Color(uiColor: .systemBackground), autoSize: true)
                .withRoundedBorder()
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static func makeDataModel(_ mode: GameMode = .add) -> GameViewDataModel {
        GameViewDataModel(mode: mode)
    }
    static var previews: some View {
        GameView(dataModel: makeDataModel()).onChalkboard()
    }
}


final class GameViewDataModel: ObservableObject {
    @Published var isPlaying = false
    
    private let mode: GameMode
    
    init(mode: GameMode) {
        self.mode = mode
    }
}


extension GameViewDataModel {
    var modeTitle: String { mode.title }
    
    func startGame() { isPlaying = true }
}


extension GameMode {
    var title: String {
        switch self {
        case .add: return "Add Three"
        }
    }
}
