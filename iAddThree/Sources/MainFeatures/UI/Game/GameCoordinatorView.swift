//
//  GameCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
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
                store: ClassicResultStoreAdapter(manager: .init(store: UserDefaultsGameStore())),
                endGame: { self.selectedMode =  nil }
            )
        } else {
            ClassicModeComposer.makeClassicModeListView(availableModes: [.add], onSelection: playSelectedMode(_:))
        }
    }
}


// MARK: - Preview
#Preview {
    GameCoordinatorView()
        .onChalkboard()
}
