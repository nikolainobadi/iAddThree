//
//  MainFeaturesViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation

public final class MainFeaturesViewModel: ObservableObject {
    @Published public var selectedMode: GameMode?
    @Published public var showingSettings = false
    
    private let store: GameModeStore
    
    public init(store: GameModeStore) {
        self.store = store
    }
}


// MARK: - Actions
public extension MainFeaturesViewModel {
    var canShowSubtractBanner: Bool {
        return store.modeLevel > 0
    }
    
    func playSelectedMode(_ mode: GameMode) throws {
        try verifyCanPlayMode(mode)
        
        selectedMode = mode
    }
    
    func endGame() {
        selectedMode = nil
    }
    
    func showSettings() {
        showingSettings = true
    }
    
    func dismissSettings() {
        showingSettings = false
    }
}


// MARK: - Private Methods
private extension MainFeaturesViewModel {
    func verifyCanPlayMode(_ mode: GameMode) throws {
        guard mode != .add else { return }
        
        let modeLevel = store.modeLevel
        
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


// MARK: - Dependencies
public protocol GameModeStore {
    var modeLevel: Int { get }
}
