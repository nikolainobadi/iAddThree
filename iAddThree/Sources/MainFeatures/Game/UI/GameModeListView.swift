//
//  GameModeListView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import SwiftUI
import iAddThreeClassicKit
import NnSwiftUIErrorHandling

struct GameModeListView: View {
    let canShowSubtractBanner: Bool
    let onSelection: (iAddThreeClassicKit.GameMode) throws -> Void
    
    var body: some View {
        VStack {
            TitleBanner(canShowSubtractBanner: canShowSubtractBanner)
                .padding()
            
            Spacer()
            LazyVStack {
                ForEach(iAddThreeClassicKit.GameMode.allCases) { mode in
                    NnTryButton("mode.name") {
                        try onSelection(mode)
                    }
//                    .buttonStyle(ChalkButtonStyle())
                }
            }
            
            Spacer()
        }
    }
}


// MARK: - Preview
#Preview {
    GameModeListView(canShowSubtractBanner: false, onSelection: { _ in })
}
