//
//  ContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        GameView(dataModel: GameViewDataModel(mode: .add))
            .onChalkboard()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
