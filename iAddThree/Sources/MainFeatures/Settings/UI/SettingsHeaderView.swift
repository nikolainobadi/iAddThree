//
//  SettingsHeaderView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI

struct SettingsHeaderView: View {
    let state: SettingsViewState
    let dismiss: () -> Void
    let showList: () -> Void
    
    var body: some View {
        VStack {
            HStack {
                NavBackButton(backAction: showList)
                    .onlyShow(when: state != .list)
                Spacer()
                NavDismissButton(dismiss: dismiss)
            }
            
            Text(state.title)
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
