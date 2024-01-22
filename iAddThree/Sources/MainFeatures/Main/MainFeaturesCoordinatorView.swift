//
//  MainFeaturesCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIKit
import iAddThreeCore
import iAddThreeClassicKit

struct MainFeaturesCoordinatorView: View {
    @StateObject var viewModel: MainFeaturesViewModel
    
    var body: some View {
        Group {
            if let selectedMode = viewModel.selectedMode {
                GameCoordinatorView(
                    adapter: .customInit(mode: selectedMode),
                    endGame: {
                        withAnimation {
                            viewModel.endGame()
                        }
                    }
                )
                .transition(.asymmetric(insertion: .push(from: .trailing), removal: .push(from: .leading)))
                .onAppear {
                    print("selected mode in view", selectedMode)
                }
            } else {
                GameModeListView(
                    modeLevel: viewModel.modeLevel,
                    onSelection: { mode in
                        try withAnimation {
                            try viewModel.playSelectedMode(mode)
                        }
                    }
                )
                .overlay(alignment: .topTrailing) {
                    SettingsButton(action: viewModel.showSettings)
                }
                .sheetWithErrorHandling(isPresented: $viewModel.showingSettings) {
                    SettingsCoordinatorView()
                        .overlay(alignment: .topTrailing) {
                            ChalkNavDismissButton(action: viewModel.dismissSettings)
                        }
                }
            }
        }
    }
}


// MARK: - SettingsButton
fileprivate struct SettingsButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: "gearshape")
        }
        .offset(y: -getHeightPercent(2))
        .padding(.horizontal)
        .font(.largeTitle)
        .foregroundStyle(.white)
    }
}


// MARK: - Preview
#Preview {
    MainFeaturesCoordinatorView(viewModel: .customInit())
        .onChalkboard()
}


// MARK: - Extension Dependencies
extension ClassicResultsAdapter {
    static func customInit(mode: GameMode) -> ClassicResultsAdapter {
        return .init(manager: .customInit(mode: mode))
    }
}

extension GameManager {
    static func customInit(mode: GameMode) -> GameManager {
        return .init(mode: mode, socialStore: GameKitSocialPerformanceStore(), performanceStore: UserDefaultsGamePerformanceStore())
    }
}
