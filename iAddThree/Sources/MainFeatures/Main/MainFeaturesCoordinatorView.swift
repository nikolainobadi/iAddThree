//
//  MainFeaturesCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import iAddThreeCore

struct MainFeaturesCoordinatorView: View {
    @State private var showingSettings = false
    
    var body: some View {
        GameCoordinatorView(viewModel: .customInit())
            .sheet(isPresented: $showingSettings) {
                SettingsCoordinatorView()
            }
    }
}


// MARK: - Preview
#Preview {
    MainFeaturesCoordinatorView()
}


// MARK: - Extension Dependencies
extension GameViewModel {
    static func customInit() -> GameViewModel {
        return .init(store: UserDefaultsGameModeStore())
    }
}
