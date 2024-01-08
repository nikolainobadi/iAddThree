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
            GameView(mode: selectedMode)
        } else {
            GameModeListView(canShowSubtractBanner: false, onSelection: viewModel.playSelectedMode(_:))
        }
    }
}


// MARK: - GameView
fileprivate struct GameView: View {
    let mode: GameMode
    
    var body: some View {
        Text("Classic")
    }
}


// MARK: - Preview
#Preview {
    GameCoordinatorView(viewModel: .customInit())
        .onChalkboard()
        .withNnErrorHandling()
}


// MARK: - Extension Dependencies
extension GameManager {
    static func customInit(mode: GameMode) -> GameManager {
        return .init(mode: mode, socialStore: GameKitSocialPerformanceStore(), performanceStore: UserDefaultsGamePerformanceStore())
    }
}

extension iAddThreeCore.GameMode {
    var classicMode: ClassicGameMode {
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
