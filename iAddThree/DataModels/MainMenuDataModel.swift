//
//  MainMenuDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/15/22.
//

import Foundation

final class MainMenuDataModel: ObservableObject {
    @Published var availableModes: [GameMode] = [.add]
    
    func updateModeLevel(_ level: Int) {
        switch level {
        case 1: availableModes = [.add]
        default: break
        }
    }
}
