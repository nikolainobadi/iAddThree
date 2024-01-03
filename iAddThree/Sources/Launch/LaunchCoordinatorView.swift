//
//  LaunchCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIHelpers

struct LaunchCoordinatorView: View {
    @State private var showingSplashScreen = true
    
    var body: some View {
        ZStack {
            MainFeaturesCoordinatorView()
                
            SplashView()
                .onlyShow(when: showingSplashScreen)
        }
    }
}


// MARK: - Preview
#Preview {
    LaunchCoordinatorView()
}
