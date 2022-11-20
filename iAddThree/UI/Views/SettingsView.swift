//
//  SettingsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/26/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: SettingsDataModel
    
    private var showingAbout: Bool { dataModel.showingAbout }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                DismissButton(dismiss: { dismiss() })
                Text("Settings")
                    .setChalkFont(.title)
            }.padding(.bottom, getHeightPercent(5))
            
            VStack {
                if showingAbout {
                    AboutView(showList: { dataModel.showingAbout = false }, aboutText: dataModel.aboutText)
                        .padding(.horizontal, 5)
                } else {
                    SettingsButtonView(dataModel: dataModel)
                }
            }.animation(.easeIn(duration: 1), value: showingAbout)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .onChalkboard()
        .overlay(Text(dataModel.versionText).setSmoothFont(.body), alignment: .bottom)
    }
}


// MARK: - About
fileprivate struct AboutView: View {
    let showList: () -> Void
    let aboutText: String
    
    var body: some View {
        VStack {
            HStack {
                Button(action: showList) {
                    Label {
                        Text("Settings List")
                            .underline()
                    } icon: {
                        Image(systemName: "chevron.left")
                    }.setSmoothFont(.body)
                }.padding(.horizontal)
                Spacer()
            }
            Text(aboutText)
                .setSmoothFont(.body)
                .padding()
        }.withTextBackground()
    }
}


// MARK: - Buttons
fileprivate struct SettingsButtonView: View {
    @State private var showingProUpgrade = false
    @ObservedObject var dataModel: SettingsDataModel
    
    private var width: CGFloat { 70 }
    
    var body: some View {
        VStack {
            VStack {
                if showingProUpgrade {
                    SettingsComposer.makeProUpgradeView(dismiss: { showingProUpgrade = false })
                } else {
                    VStack(spacing: getHeightPercent(5)) {
                        Button(action: { showingProUpgrade = true }) {
                            Text("Remove Ads")
                                .frame(width: getWidthPercent(width))
                                .withRoundedBorder()
                        }
                        
                        Link("Send Feedback", destination: URL(string: dataModel.emailURL)!)
                            .frame(width: getWidthPercent(width))
                            .withRoundedBorder()
                        
                        Button(action: dataModel.rateApp) {
                            Text("Rate App")
                                .frame(width: getWidthPercent(width))
                                .withRoundedBorder()
                        }
                        
                        Button(action: dataModel.showAbout) {
                            Text("About")
                                .frame(width: getWidthPercent(width))
                                .withRoundedBorder()
                        }
                        
                        Link("Privacy Policy", destination: URL(string: dataModel.privacyPolicyURL)!)
                            .frame(width: getWidthPercent(width))
                            .withRoundedBorder()
                    }.transition(.opacity)
                }
            }.animation(.default, value: showingProUpgrade)
        }.setSmoothFont(.headline)
    }
}


// MARK: - Preview
struct SettingsView_Previews: PreviewProvider {
    static var dataModel: SettingsDataModel { SettingsDataModel(versionNumber: "2.0.1", requestAppReview: { }) }
    
    static var previews: some View {
        SettingsView(dataModel: dataModel)
    }
}
