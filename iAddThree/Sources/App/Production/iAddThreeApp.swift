//
//  iAddThreeApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI

struct iAddThreeApp: App {
    var body: some Scene {
        WindowGroup {
            LaunchCoordinatorView()
                .withErrorHandling()
                .preferredColorScheme(.light)
        }
    }
}
