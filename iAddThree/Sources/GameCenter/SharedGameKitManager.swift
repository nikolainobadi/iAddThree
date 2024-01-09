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
    static func loadHighScore(leaderboardId: String) async -> Int? {
        guard localPlayer.isAuthenticated else { return nil }
        
        return nil
    }
    
    static func saveHighScore(score: Int, leaderboardId: String) {
        guard localPlayer.isAuthenticated else { return }
        
        Task {
            try? await submitScore(score: score, leaderboardId: leaderboardId)
        }
    }
}


// MARK: - Achievements
extension SharedGameKitManager {
    static func reportAchievementList(idList: [String]) {
        let achievements = idList.map({ makeGKAchievement(id: $0) })
        
        GKAchievement.report(achievements, withCompletionHandler: { error in
            if let error = error {
                print("Error reporting achievement: \(error.localizedDescription)")
            }
        })
    }
}


// MARK: - Private Methods
private extension SharedGameKitManager {
    static func loadHighScore(_ leaderboardId: String) async throws -> Int? {
        let leaderboards = try await GKLeaderboard.loadLeaderboards(IDs: [leaderboardId])
        guard let leaderboard = leaderboards.first(where: { $0.baseLeaderboardID == leaderboardId }) else { return nil }
        
        let (localPlayerEntry, _, _) = try await leaderboard.loadEntries(for: .global, timeScope: .allTime, range: NSRange(location: 1, length: 1))
        
        return localPlayerEntry?.score
    }
    
    static func submitScore(score: Int, leaderboardId: String) async throws {
        try await GKLeaderboard.submitScore(score, context: 0, player: localPlayer, leaderboardIDs: [leaderboardId])
    }
    
    static func makeGKAchievement(id: String) -> GKAchievement {
        let achievement = GKAchievement(identifier: id)
        achievement.percentComplete = 100
        achievement.showsCompletionBanner = true
        
        return achievement
    }
}
