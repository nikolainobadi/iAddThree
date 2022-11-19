//
//  SettingsDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/26/22.
//

import Foundation

final class SettingsDataModel: ObservableObject {
    @Published var showingAbout = false
    
    private let versionNumber: String?
    private let requestAppReview: () -> Void
    let emailURL = "mailto:nnobadicares@gmail.com"
    let privacyPolicyURL = "https://github.com/nikolainobadi/PrivacyPolicies/blob/main/iAddThree/iAddThree_PrivacyPolicy.md"
    
    
    
    init(versionNumber: String?, requestAppReview: @escaping () -> Void) {
        self.versionNumber = versionNumber
        self.requestAppReview = requestAppReview
    }
}


extension SettingsDataModel {
    var versionText: String {
        guard let versionNumber = versionNumber else { return "" }
        
        return "Version \(versionNumber)"
    }
    var aboutText: String {
        """
        iAddThree was inspired by a mental exercise presented in the book *Thinking Fast and Slow*, by nobel prize winning psychologist, Daniel Kahneman.
        
        The game is designed to train your 'working memory' (short-term memory) by simulating the cognitive stress than can occur when you try to maintain multiple pieces of information at the same time.
        """
    }
    
    func rateApp() { requestAppReview() }
    func showAbout() { showingAbout = true }
}
