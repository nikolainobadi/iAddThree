//
//  MainFeaturesCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI

struct MainFeaturesCoordinatorView: View {
    @State private var showingSettings = false
    
    var body: some View {
        GameCoordinatorView()
            .sheet(isPresented: $showingSettings) {
                SettingsCoordinatorView()
            }
    }
}


// MARK: - Preview
#Preview {
    MainFeaturesCoordinatorView()
}
