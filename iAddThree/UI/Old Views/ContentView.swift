//
//  ContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

enum ContentComposer {
    static func makeGameView(mode: GameMode = .add) -> some View {
        let highScoreStore = UserDefaultsHighScoreStore(mode: mode)
        let store = GameStorageManager(store: highScoreStore)
        let dataModel = GameViewDataModel(mode: mode, store: store)
        
        return GameView(dataModel: dataModel)
    }
}

struct ContentView: View {
    var body: some View {
        ContentComposer.makeGameView()
            .onChalkboard()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
