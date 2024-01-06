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
                mode: selectedMode.classicMode,
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
    static func customInit(mode: iAddThreeCore.GameMode) -> GameManager {
        return .init(mode: mode, store: UserDefaultsGameStore())
    }
}

extension iAddThreeCore.GameMode {
    var classicMode: iAddThreeClassicKit.GameMode {
        switch self {
        case .add:
            return .add
        case .subtract:
            return .subtract
        case .hybrid:
            return .hybrid
        }
    }
}
