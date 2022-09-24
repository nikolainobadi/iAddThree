//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct GameView: View {
    @State var isPlaying = false
    
    private func showInstructions() { }
    private func startGame() {
        withAnimation {
            isPlaying = true
        }
    }
    
    private func finishLevel(_ pointsToAdd: Int) {
        
    }
    
    var body: some View {
        VStack {
            if isPlaying {
                GameViewComposer.makePlayView(.add, finished: finishLevel(_:))
                    .transition(.scale)
            } else {
                ChalkButton("Start Game", style: .title2, action: startGame)
                ChalkButton("How to Play", style: .subheadline, action: showInstructions)
            }
        }.animation(.default, value: isPlaying)
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
    static var previews: some View {
        GameView().onChalkboard()
    }
}
