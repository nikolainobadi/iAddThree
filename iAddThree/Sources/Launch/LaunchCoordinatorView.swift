//
//  LaunchCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIHelpers
import iAddThreeClassicKit

struct LaunchCoordinatorView: View {
    @State private var showingSplashScreen = true
    
    var body: some View {
        ZStack {
            MainFeaturesCoordinatorView()
                
            SplashView()
                .onlyShow(when: showingSplashScreen)
                .delayedOnAppear(seconds: 3) {
                    showingSplashScreen = false
                }
        }
        .onChalkboard()
    }
}


// MARK: - Preview
#Preview {
    LaunchCoordinatorView()
}
