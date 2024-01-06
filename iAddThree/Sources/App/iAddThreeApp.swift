//
//  iAddThreeApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIErrorHandling

@main
struct iAddThreeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchCoordinatorView()
                .withNnErrorHandling()
        }
    }
}
