//
//  SettingsHeaderView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI
import iAddThreeClassicKit

struct SettingsHeaderView: View {
    let state: SettingsViewState
    let didPurchasePro: Bool
    let showList: () -> Void
    
    var title: String {
        if state == .upgrade && didPurchasePro {
            return "Thank You"
        }
        
        return state.title
    }
    
    var body: some View {
        VStack {
            HStack {
                ChalkNavBackButton(text: "Back", action: showList)
                    .onlyShow(when: state != .list)
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, getHeightPercent(2))
            
            Text(title)
                .lineLimit(1)
                .setChalkFont(.title, autoSize: true)
                .padding(.horizontal)
                .padding(.top, state == .list ? 0 : getHeightPercent(2)) // top padding prevents issues with back button
        }
    }
}


// MARK: - BackButton
fileprivate struct NavBackButton: View {
    let backAction: () -> Void
    
    var body: some View {
        HStack {
            Button(action: backAction) {
                Label {
                    Text("Back")
                } icon: {
                    Image(systemName: "chevron.left")
                }
                .setChalkFont(.body)
            }
            .padding(.horizontal)
        }
    }
}


// MARK: - DisissButton
fileprivate struct NavDismissButton: View {
    let dismiss: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: dismiss) {
                Image(systemName: "xmark")
                    .padding(.horizontal)
                    .setChalkFont(.subheadline)
            }
        }
    }
}
