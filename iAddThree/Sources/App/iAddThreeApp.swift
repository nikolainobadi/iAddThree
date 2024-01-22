//
//  iAddThreeApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIKit

@main
struct iAddThreeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchCoordinatorView()
                .withNnLoadingView()
                .withNnErrorHandling()
                .preferredColorScheme(.light)
        }
    }
}
