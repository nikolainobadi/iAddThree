//
//  SharedGameKitManager.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/7/24.
//

import GameKit

enum SharedGameKitManager {
    static var localPlayer: GKLocalPlayer {
        return GKLocalPlayer.local
    }
}


// MARK: - Auth
extension SharedGameKitManager {
    static func authenticateLocalPlayer(presentingViewController: UIViewController, completion: @escaping (Bool, Error?) -> Void) {
        localPlayer.authenticateHandler = { viewController, error in
            if let vc = viewController {
                presentingViewController.present(vc, animated: true, completion: nil)
            } else if localPlayer.isAuthenticated {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }
}


// MARK: - Leaderboard
extension SharedGameKitManager {
    static func saveHighScore(score: Int, leaderboardId: String) {
        guard localPlayer.isAuthenticated else { return }
        
        Task {
            try? await submitScore(score: score, leaderboardId: leaderboardId)
        }
    }
}


// MARK: - Achievements
extension SharedGameKitManager {
    static func reportAchievement(achievementID: String, percentComplete: Double) {
        guard localPlayer.isAuthenticated else { return }
        
        let achievement = GKAchievement(identifier: achievementID)
        achievement.percentComplete = percentComplete
        achievement.showsCompletionBanner = true  // Show banner if achievement is completed
        
        GKAchievement.report([achievement], withCompletionHandler: { error in
            if let error = error {
                print("Error reporting achievement: \(error.localizedDescription)")
            }
        })
    }
}


// MARK: - Private Methods
private extension SharedGameKitManager {
    static func submitScore(score: Int, leaderboardId: String) async throws {
        try await GKLeaderboard.submitScore(score, context: 0, player: localPlayer, leaderboardIDs: [leaderboardId])
    }
}
