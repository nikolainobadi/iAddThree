//
//  GameNavView.swift
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
struct GameNavView: View {
    @State private var state: GameState = .menu
    
    var body: some View {
        VStack {
            GameTitle(title: "Add Three", isPlaying: state == .playing)
            GameContentView(state: $state)
        }
        .overlay(GameViewNavBar(state: $state), alignment: .top)
        .overlay(GameScoreFooter(state: state), alignment: .bottom)
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


// MARK: - GameContent
fileprivate struct GameContentView: View {
    @Binding var state: GameState
    
    private func startGame() { state = .playing }
    private func submitAnswer(_ number: String) { }
    private func makeNumberList() -> [NumberItemPresenter] {
        NumberItemFactory.makeNumberList(.add).map({ NumberItemPresenter($0) })
    }
    
    var body: some View {
        switch state {
        case .menu:
            GameModeMenu(startGame: startGame)
                .transition(.scale)
        case .playing:
            PlayView(numberList: makeNumberList(), submitAnswer: submitAnswer)
                .transition(.scale)
        case .results(let levelResultInfo):
            ResultsView(results: levelResultInfo, playAgain: startGame)
        }
    }
}


// MARK: - Menu
fileprivate struct GameModeMenu: View {
    @State private var showingInstructions = false
    
    let startGame: () -> Void
    
    var body: some View {
        VStack {
            ChalkButton("Start Game", style: .title2, action: startGame)
            ChalkButton("How to Play", style: .subheadline, action: { showingInstructions = true })
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
    }
}


// MARK: - PlayView
fileprivate struct PlayView: View {
    let numberList: [NumberItemPresenter]
    let submitAnswer: (String) -> Void
    
    var body: some View {
        VStack {
            NumberListView(list: numberList)
            Spacer()
            NumberPadView(selection: submitAnswer)
                .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(55))
            Spacer()
        }
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


// MARK: - Footer
fileprivate struct GameScoreFooter: View {
    let state: GameState
    
    var body: some View {
        VStack {
            switch state {
            case .menu:
                VStack {
                    
                }.frame(maxWidth: .infinity, alignment: .center)
            case .playing:
                VStack(alignment: .leading) {
                    Text("Score: 0")
                    Text("High Score: 0")
                }
                .setChalkFont(.body)
                .frame(maxWidth: .infinity, alignment: .leading)
            case .results:
                EmptyView()
            }
        }.padding()
    }
}


// MARK: - Preview
struct GameNavView_Previews: PreviewProvider {
    static var previews: some View {
        GameNavView()
            .onChalkboard()
    }
}
