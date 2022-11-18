//
//  iAddThreeApp.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if NSClassFromString("XCTestCase") == nil {
            iAddThreeApp.main()
        } else {
            TestApp.main()
        }
    }
}


struct iAddThreeApp: App {
    init() {
        ATTAdapter.initializeAdService()
    }
    
    var body: some Scene {
        WindowGroup {
            MainMenu()
                .onChalkboard()
        }
    }
}


struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
