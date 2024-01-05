//
//  GameCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import iAddThreeCore
import iAddThreeClassicKit

struct GameCoordinatorView: View {
    @State private var selectedMode: GameMode?
    
    private func playSelectedMode(_ mode: GameMode) {
        selectedMode = mode
    }
    
    var body: some View {
        if let selectedMode = selectedMode {
            ClassicModeComposer.makeClassicGameCoordinatorView(
                mode: selectedMode,
                store: ClassicResultStoreAdapter(manager: .customInit(mode: selectedMode)),
                endGame: { self.selectedMode =  nil }
            )
        } else {
            VStack {
                TitleBanner(canShowSubtractBanner: false)
                    .padding()
                
                Spacer()
                
                ClassicModeComposer.makeClassicModeListView(availableModes: [.add], onSelection: playSelectedMode(_:))
                
                Spacer()
            }
        }
    }
}


// MARK: - Preview
#Preview {
    GameCoordinatorView()
        .onChalkboard()
}


// MARK: - Extension Dependencies
extension GameManager {
    static func customInit(mode: GameMode) -> GameManager {
        return .init(store: UserDefaultsGameStore(modeId: mode.id))
    }
}
