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
    let canShowSubtractBanner: Bool
    let onSelection: (GameMode) throws -> Void
    
    var body: some View {
        VStack {
            TitleBanner(canShowSubtractBanner: canShowSubtractBanner)
                .padding()
            
            Spacer()
            LazyVStack {
                ForEach(GameMode.allCases) { mode in
                    NnTryButton(mode.name) {
                        try onSelection(mode)
                    }
                    .buttonStyle(ChalkButtonStyle(frameWidth: getWidthPercent(70)))
                }
            }
            
            Spacer()
        }
    }
}


// MARK: - Preview
#Preview {
    GameModeListView(canShowSubtractBanner: false, onSelection: { _ in })
        .onChalkboard()
}
