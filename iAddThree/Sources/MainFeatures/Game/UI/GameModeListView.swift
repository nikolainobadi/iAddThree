//
//  GameModeListView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import SwiftUI
import iAddThreeCore
import NnSwiftUIHelpers
import iAddThreeClassicKit
import NnSwiftUIErrorHandling

struct GameModeListView: View {
    let modeLevel: Int
    let onSelection: (GameMode) throws -> Void
    
    var body: some View {
        VStack {
            TitleBanner(canShowSubtractBanner: modeLevel > 0)
                .padding()
            
            Spacer()
            VStack {
                ForEach(GameMode.allCases) { mode in
                    ButtonRow(mode: mode, isAvailable: modeLevel >= mode.modeLevelRequirement, onSelection: onSelection)
                }
            }
            
            Spacer()
        }
    }
}


// MARK: - ButtonRow
fileprivate struct ButtonRow: View {
    let mode: GameMode
    let isAvailable: Bool
    let onSelection: (GameMode) throws -> Void
    
    private var textColor: Color {
        return isAvailable ? .white : .red
    }
    
    var body: some View {
        NnTryButton(mode.name) {
            try onSelection(mode)
        }
        .buttonStyle(ChalkButtonStyle(textColor: textColor, frameWidth: getWidthPercent(70)))
        .opacity(isAvailable ? 1 : 0.5)
    }
}


// MARK: - Preview
#Preview {
    GameModeListView(modeLevel: 0, onSelection: { _ in })
        .onChalkboard()
}


// MARK: - Extension Depdencies
fileprivate extension GameMode {
    var modeLevelRequirement: Int {
        switch self {
        case .add:
            return 0
        case .subtract:
            return 1
        case .hybrid:
            return 2
        }
    }
}
