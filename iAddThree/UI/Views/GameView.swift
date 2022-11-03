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
    case results(LevelResultInfo)
}


// MARK: - Main View
struct GameView: View {
    @State private var state: GameState = .menu
    
    let mode: GameMode
    
    var body: some View {
        VStack(spacing: 0) {
            GameTitle(title: "Add Three", isPlaying: state == .playing)
            GameContentView(state: $state, mode: mode)
        }
        .overlay(GameViewNavBar(state: $state), alignment: .top)
        .animation(.easeInOut(duration: 0.75), value: state)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
}


// MARK: - NavBar
fileprivate struct GameViewNavBar: View {
    @Binding var state: GameState
    @State private var hideBackButton = false
    
    var body: some View {
        HStack {
            Button(action: { hideBackButton = false; state = .menu }, label: { Label("Back", systemImage: "chevron.left") })
                .opacity(hideBackButton ? 0 : state == .playing ? 1 : 0)
            Spacer()
            Button(action: { }, label: { Image(systemName: "gearshape") })
                .opacity(state == .menu ? 1 : 0)
        }
        .padding()
        .setChalkFont(.subheadline)
        .animation(.easeInOut(duration: 0.25), value: state)
    }
}


// MARK: - Title
fileprivate struct GameTitle: View {
    let title: String
    let isPlaying: Bool
    
    var body: some View {
        Text(title).setChalkFont(.largeTitle, autoSize: true)
            .padding()
            .lineLimit(1)
            .scaleEffect(isPlaying ? 0.75 : 1)
            .offset(y: getHeightPercent(isPlaying ? 2 : 5))
    }
}


// MARK: - Preview
struct GameNavView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(mode: .add)
            .onChalkboard()
    }
}
