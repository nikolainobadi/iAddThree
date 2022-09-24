//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct GameView: View {
    @StateObject var dataModel: GameViewDataModel
    
    private func showInstructions() { }
    
    private func finishLevel(_ pointsToAdd: Int) {
        
    }
    
    var body: some View {
        VStack {
            if dataModel.isPlaying {
                GameViewComposer.makePlayView(.add, finished: finishLevel(_:))
                    .transition(.scale)
            } else {
                ChalkButton("Start Game", style: .title2, action: dataModel.startGame)
                ChalkButton("How to Play", style: .subheadline, action: showInstructions)
            }
        }.animation(.default, value: dataModel.isPlaying)
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
    static var dataModel: GameViewDataModel {
        GameViewDataModel()
    }
    static var previews: some View {
        GameView(dataModel: dataModel).onChalkboard()
    }
}


final class GameViewDataModel: ObservableObject {
    @Published var isPlaying = false
}


extension GameViewDataModel {
    func startGame() { isPlaying = true }
}
