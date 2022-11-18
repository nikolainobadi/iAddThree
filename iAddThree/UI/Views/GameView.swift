//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 10/30/22.
//

import SwiftUI

enum GameState: Equatable {
    case menu
    case playing
    case results(LevelResults)
}


// MARK: - Main View
struct GameView: View {
    @State private var state: GameState = .menu
    
    let mode: GameMode
    let dismiss: () -> Void
    
    private var title: String {
        switch mode {
        case .add : return "Add Three"
        case .subtract: return "Subtract Three"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            GameTitle(title: title, showingMenu: state == .menu)
            GameContentComposer.makeGameContentView(state: $state, mode: mode) 
        }
        .animation(.easeInOut(duration: 0.75), value: state)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(
            GameViewNavBar(state: $state, dismiss: dismiss)
            , alignment: .top
        )
    }
}


// MARK: - NavBar
fileprivate struct GameViewNavBar: View {
    @Binding var state: GameState
    @State private var hideBackButton = false
    
    let dismiss: () -> Void
    
    private func buttonAction() {
        switch state {
        case .menu, .results: dismiss()
        case .playing: state = .menu
        }
    }
    
    var body: some View {
        HStack {
            Button(action: buttonAction) {
                if state == .playing {
                    Label("Back", systemImage: "chevron.left")
                } else {
                    Text("MainMenu")
                }
            }
            
            Spacer()
        }
        .padding()
        .setChalkFont(.subheadline)
        .animation(.easeInOut(duration: 0.25), value: state)
    }
}


// MARK: - Title
fileprivate struct GameTitle: View {
    let title: String
    let showingMenu: Bool
    
    var body: some View {
        Text(title).setChalkFont(.largeTitle, autoSize: true)
            .padding()
            .lineLimit(1)
            .scaleEffect(showingMenu ? 1 : 0.6)
            .offset(y: getHeightPercent(showingMenu ? 8 : 3))
    }
}


// MARK: - Preview
struct GameNavView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(mode: .add, dismiss: { })
            .onChalkboard()
    }
}
