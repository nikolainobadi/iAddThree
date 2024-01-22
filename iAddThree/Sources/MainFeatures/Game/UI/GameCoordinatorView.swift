//
//  GameCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIKit
import iAddThreeCore
import iAddThreeClassicKit

struct GameCoordinatorView: View {
    @StateObject var adapter: ClassicResultsAdapter
    
    let endGame: () -> Void
    
    var body: some View {
        ClassicGameCoordinatorView(
            mode: adapter.mode,
            highScore: adapter.currentHighScore,
            endGame: endGame,
            saveResults: adapter.saveResults(_:)
        )
        .task {
            await adapter.loadHighScore()
        }
    }
}



// MARK: - Preview
#Preview {
    GameCoordinatorView(adapter: .init(manager: .customInit(mode: .add)), endGame: { })
        .onChalkboard()
        .withNnErrorHandling()
}


// MARK: - Extension Dependencies
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
