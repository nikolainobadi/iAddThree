//
//  MainMenu.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/14/22.
//

import SwiftUI

struct MainMenu: View {
    @State private var selectedMode: GameMode?
    @StateObject private var dataModel = MainMenuDataModel()
    
    private var availableModes: [GameMode] { dataModel.availableModes }
    private func playMode(_ mode: GameMode) { selectedMode = mode }
    
    var body: some View {
        VStack {
            Text("iAddThree")
                .setChalkFont(.largeTitle)
            Spacer()
            ModeButtonsView(modes: availableModes, playMode: playMode(_:))
            Spacer()
        }.fullScreenCover(item: $selectedMode) { GameView(mode: $0).onChalkboard() }
    }
}


// MARK: - ModeButtonsList
fileprivate struct ModeButtonsView: View {
    let modes: [GameMode]
    let playMode: (GameMode) -> Void
    
    var body: some View {
        VStack {
            ForEach(modes, id: \.self) { mode in
                ChalkButton(mode.title, action: { playMode(mode) })
            }
        }
    }
}

final class MainMenuDataModel: ObservableObject {
    @Published var availableModes: [GameMode] = [.add]
}


// MARK: - Preview
struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
            .onChalkboard()
    }
}
