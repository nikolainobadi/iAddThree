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

    private var title: String { dataModel.title }
    private var showBackButton: Bool { state == .upgrade }
    private var state: SettingsViewState { dataModel.state }
    
    private func showList() { dataModel.show(.list) }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                HStack {
                    Button(action: showList) {
                        Label {
                            Text("Back")
                        } icon: {
                            Image(systemName: "chevron.left")
                        }.setChalkFont(.body)
                    }
                    .padding(.horizontal)
                    .opacity(showBackButton ? 1 : 0)
                    
                    Spacer()
                    DismissButton(dismiss: { dismiss() })
                }
                
                Text(title)
                    .lineLimit(1)
                    .setChalkFont(.title, autoSize: true)
                    .padding(.horizontal)
                    .padding(.top, state == .upgrade ? getHeightPercent(2) : 0)
            }.padding(.bottom, getHeightPercent(5))
            
            VStack {
                switch state {
                case .list:
                    SettingsButtonView(dataModel: dataModel)
                case .about:
                    AboutView(showList: showList, aboutText: dataModel.aboutText)
                        .padding(.horizontal, 5)
                case .upgrade:
                    SettingsComposer.makeProUpgradeView()
                }
            }
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
        VStack(spacing: getHeightPercent(5)) {
            Button(action: { dataModel.show(.upgrade) }) {
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
            
            Button(action: { dataModel.show(.about) }) {
                Text("About")
                    .frame(width: getWidthPercent(width))
                    .withRoundedBorder()
            }
            
            Link("Privacy Policy", destination: URL(string: dataModel.privacyPolicyURL)!)
                .frame(width: getWidthPercent(width))
                .withRoundedBorder()
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
