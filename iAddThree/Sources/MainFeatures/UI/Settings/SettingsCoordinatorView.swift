//
//  SettingsCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIHelpers
import iAddThreeClassicKit

fileprivate enum SettingsViewState {
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

struct SettingsCoordinatorView: View {
    @State private var state: SettingsViewState = .list
    
    private var versionNumber: String {
        return AppVersionCache.getVersionDetails()
    }
    
    private func rateApp() {
        AppRater.rateApp()
    }
    
    var body: some View {
        VStack {
            VStack {
                Text(state.title)
                    .lineLimit(1)
                    .setChalkFont(.title, autoSize: true)
                    .padding(.horizontal)
                    .padding(.top, state == .upgrade ? getHeightPercent(2) : 0)
            }
            .padding(.bottom, getHeightPercent(5))
            
            switch state {
            case .list:
                SettingsButtonListView(
                    rateApp: rateApp, 
                    showAbout: { state = .about },
                    showUpgrade: { state = .upgrade }
                )
            case .about:
                Text("About")
            case .upgrade:
                Text("Upgrade")
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
