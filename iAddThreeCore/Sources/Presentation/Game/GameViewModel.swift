//
//  GameViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation

public final class GameViewModel: ObservableObject {
    @Published public var selectedMode: GameMode?
    
    private let store: GameModeStore
    
    public init(store: GameModeStore) {
        self.store = store
    }
}


// MARK: - Actions
public extension GameViewModel {
    func playSelectedMode(_ mode: GameMode) throws {
        try verifyCanPlayMode(mode)
        
        selectedMode = mode
    }
}


// MARK: - Private Methods
private extension GameViewModel {
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
