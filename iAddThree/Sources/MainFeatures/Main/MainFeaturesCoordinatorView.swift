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
        NavigationStack {
            GameModeListView(
                modeLevel: viewModel.modeLevel,
                onSelection: viewModel.playSelectedMode(_:)
            )
            .onChalkboard()
            .overlay(alignment: .topTrailing) {
                SettingsButton(action: viewModel.showSettings)
            }
            .sheetWithErrorHandling(isPresented: $viewModel.showingSettings) {
                SettingsCoordinatorView()
                    .overlay(alignment: .topTrailing) {
                        ChalkNavDismissButton(action: viewModel.dismissSettings)
                    }
            }
            .navigationDestination(item: $viewModel.selectedMode) { mode in
                GameCoordinatorView(
                    adapter: .customInit(mode: mode),
                    endGame: viewModel.endGame
                )
                .navigationBarBackButtonHidden()
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
