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
    @StateObject var viewModel: GameViewModel
    
    var body: some View {
        if let selectedMode = viewModel.selectedMode {
            ClassicModeComposer.makeClassicGameCoordinatorView(
                mode: selectedMode,
                store: ClassicResultStoreAdapter(manager: .customInit(mode: selectedMode)),
                endGame: { viewModel.selectedMode =  nil }
            )
        } else {
            GameModeListView(canShowSubtractBanner: false, onSelection: viewModel.playSelectedMode(_:))
        }
    }
}


// MARK: - Preview
#Preview {
    GameCoordinatorView(viewModel: .init())
        .onChalkboard()
        .withNnErrorHandling()
}


// MARK: - Extension Dependencies
extension GameManager {
    static func customInit(mode: iAddThreeClassicKit.GameMode) -> GameManager {
        return .init(modeId: mode.id, store: UserDefaultsGameStore())
    }
}
