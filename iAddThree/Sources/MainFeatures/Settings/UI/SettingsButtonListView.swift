//
//  SettingsButtonListView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI
import iAddThreeClassicKit

fileprivate let EMAIL_URL = "mailto: nnobadicares@gmail.com"
fileprivate let PRIVACY_URL = "https://nikolainobadi.github.io/iAddThree.github.io/privacy-policy.html"

struct SettingsButtonListView: View {
    let didPurchasePro: Bool
    
    let rateApp: () -> Void
    let showAbout: () -> Void
    let showUpgrade: () -> Void
    
    var body: some View {
        VStack(spacing: getHeightPercent(5)) {
            NormalButton(title: "Remove Ads", action: showUpgrade)
                .onlyShow(when: !didPurchasePro)
            
            LinkButton(title: "Send Feedback", urlString: EMAIL_URL)
            NormalButton(title: "Rate App", action: rateApp)
            NormalButton(title: "About", action: showAbout)
            LinkButton(title: "Privacy Policy", urlString: PRIVACY_URL)
        }
        .setChalkFont(.headline, isSmooth: true, textColor: .black)
    }
}


// MARK: - NormalButton
fileprivate struct NormalButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(width: getWidthPercent(70))
                .withRoundedBorder()
        }
    }
}


// MARK: - LinkButton
fileprivate struct LinkButton: View {
    let title: String
    let urlString: String
    var body: some View {
        Link(title, destination: URL(string: urlString)!)
            .frame(width: getWidthPercent(70))
            .withRoundedBorder()
    }
}
