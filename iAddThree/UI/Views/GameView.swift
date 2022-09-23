//
//  GameView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct GameView: View {
    @State var isPlaying = false
    
    var body: some View {
        VStack {
            if isPlaying {
                // playView
                
            } else {
                // menuButtons
            }
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView().onChalkboard()
    }
}
