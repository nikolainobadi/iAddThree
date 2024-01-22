//
//  SettingsCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIHelpers
import iAddThreeClassicKit

struct SettingsCoordinatorView: View {
    @State private var state: SettingsViewState = .list
    @Environment(\.didPurchasePro) private var didPurchasePro
    
    private var versionNumber: String {
        return AppVersionCache.getVersionDetails()
    }
    
    private func rateApp() {
        AppRater.rateApp()
    }
    
    var body: some View {
        VStack {
            SettingsHeaderView(state: state, didPurchasePro: didPurchasePro, showList: { state = .list })
                .padding(.bottom, getHeightPercent(5))
            
            switch state {
            case .list:
                SettingsButtonListView(
                    didPurchasePro: didPurchasePro,
                    rateApp: rateApp,
                    showAbout: { state = .about },
                    showUpgrade: { state = .upgrade }
                )
            case .about:
                Text(state.detailText)
                    .padding()
                    .withTextBackground()
                    .setChalkFont(.body, isSmooth: true)
            case .upgrade:
                ProUpgradeView(viewModel: .init(store: InAppPurchaseStoreAdapter()), didPurchasePro: didPurchasePro)
            }
            
            Spacer()
            
            Text(versionNumber)
                .onlyShow(when: state != .upgrade)
                .setChalkFont(.body, isSmooth: true, textColor: .white)
        }
        .onChalkboard()
    }
}


// MARK: - Preview
#Preview {
    SettingsCoordinatorView()
}


// MARK: - Dependencies
enum SettingsViewState {
    case list, about, upgrade
}

extension SettingsViewState {
    var title: String {
        switch self {
        case .list:
            return "Settings"
        case .about:
            return "About iAddThree"
        case .upgrade:
            return "Pro Upgrade"
        }
    }
}

extension SettingsViewState {
    var detailText: String {
        switch self {
        case .about:
            return "iAddThree was inspired by a mental exercise presented in the book *Thinking Fast and Slow*, by nobel prize winning psychologist, Daniel Kahneman.\n\nThe game is designed to train your 'working memory' (short-term memory) by simulating the cognitive stress than can occur when you try to maintain multiple pieces of information at the same time."
        default:
            return ""
        }
    }
}
