//
//  GameViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation
import iAddThreeClassicKit

final class GameViewModel: ObservableObject {
    @Published var selectedMode: iAddThreeClassicKit.GameMode?
    
    private let defaults: UserDefaults
    
    init(selectedMode: iAddThreeClassicKit.GameMode? = nil, defaults: UserDefaults = .standard) {
        self.selectedMode = selectedMode
        self.defaults = defaults
    }
}


// MARK: - Actions
extension GameViewModel {
    func playSelectedMode(_ mode: iAddThreeClassicKit.GameMode) throws {
        try verifyCanPlayMode(mode)
        
        selectedMode = mode
    }
}


// MARK: - Private Methods
private extension GameViewModel {
    func verifyCanPlayMode(_ mode: iAddThreeClassicKit.GameMode) throws {
        guard mode != .add else { return }
        
        let modeLevel = defaults.integer(forKey: AppStorageKey.modeLevel)
        
        switch mode {
        case .subtract:
            if modeLevel < 1 {
                throw ModeLevelError.subtract
            }
        case .hybrid:
            if modeLevel < 2 {
                throw ModeLevelError.hybrid
            }
        default:
            throw ModeLevelError.unknown
        }
    }
}
