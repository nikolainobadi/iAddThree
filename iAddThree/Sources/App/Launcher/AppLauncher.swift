//
//  AppLauncher.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/25/24.
//

import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if ProcessInfo.isTesting {
            TestApp.main()
        } else {
            iAddThreeApp.main()
        }
    }
}
