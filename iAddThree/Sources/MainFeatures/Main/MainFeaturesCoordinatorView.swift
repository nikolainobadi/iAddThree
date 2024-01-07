//
//  MainFeaturesCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import iAddThreeCore
import NnSwiftUIHelpers
import iAddThreeClassicKit

struct MainFeaturesCoordinatorView: View {
    @State private var showingSettings = false
    
    var body: some View {
        GameCoordinatorView(viewModel: .customInit())
            .overlay(alignment: .topTrailing) {
                Button(action: { showingSettings = true }) {
                    Image(systemName: "gearshape")
                }
                .offset(y: -getHeightPercent(2))
                .padding(.horizontal)
                .font(.largeTitle)
                .foregroundStyle(.white)
                
            }
            .sheet(isPresented: $showingSettings) {
                SettingsCoordinatorView()
                    .overlay(alignment: .topTrailing) {
                        ChalkNavDismissButton(action: { showingSettings = false })
                    }
            }
    }
}


// MARK: - Preview
#Preview {
    MainFeaturesCoordinatorView()
        .onChalkboard()
}


// MARK: - Extension Dependencies
extension GameViewModel {
    static func customInit() -> GameViewModel {
        return .init(store: UserDefaultsGamePerformanceStore())
    }
}
