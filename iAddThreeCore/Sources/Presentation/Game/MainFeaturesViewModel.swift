//
//  MainFeaturesViewModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/6/24.
//

import Foundation

/// `MainFeaturesViewModel` is the view model for managing the main UI features of the iAddThree game.
/// It handles the current game mode selection, settings visibility, and game actions.
public final class MainFeaturesViewModel: ObservableObject {
    /// The currently selected game mode.
    @Published public var selectedMode: GameMode?

    /// Boolean value indicating whether the settings view is currently being shown.
    @Published public var showingSettings = false

    /// Store containing game mode related data and configurations.
    private let store: GameModeStore

    /// Initializes the view model with a game mode store.
    /// - Parameter store: A `GameModeStore` instance for accessing game mode related data.
    public init(store: GameModeStore) {
        self.store = store
    }
}

// MARK: - Actions
public extension MainFeaturesViewModel {
    /// Current level of the selected game mode.
    var modeLevel: Int {
        return store.modeLevel
    }
    
    /// Determines if the subtract mode banner should be shown, based on the level.
    var canShowSubtractBanner: Bool {
        return store.modeLevel > 0
    }
    
    /// Sets the selected game mode for playing.
    /// - Parameter mode: `GameMode` to be played.
    /// - Throws: `ModeLevelError` if the mode cannot be played due to level restrictions.
    func playSelectedMode(_ mode: GameMode) throws {
        try verifyCanPlayMode(mode)
        selectedMode = mode
    }
    
    /// Ends the current game, resetting the selected mode.
    func endGame() {
        selectedMode = nil
    }
    
    /// Shows the settings view.
    func showSettings() {
        showingSettings = true
    }
    
    /// Dismisses the settings view.
    func dismissSettings() {
        showingSettings = false
    }
}

// MARK: - Private Methods
private extension MainFeaturesViewModel {
    /// Verifies if a certain game mode can be played based on current level and restrictions.
    /// - Parameter mode: `GameMode` to be verified.
    /// - Throws: `ModeLevelError` if the mode cannot be played.
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
/// Protocol defining the necessary properties and methods for a game mode store.
public protocol GameModeStore {
    /// Current level of the game mode.
    var modeLevel: Int { get }
}

