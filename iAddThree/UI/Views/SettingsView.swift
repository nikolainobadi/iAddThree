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


// MARK: - DismissButton
fileprivate struct DismissButton: View {
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
                
        }
        .background(.black.opacity(0.5))
        .cornerRadius(20)
        .padding(5)
    }
}


// MARK: - Buttons
fileprivate struct SettingsButtonView: View {
    @ObservedObject var dataModel: SettingsDataModel
    
    private let width: CGFloat = 70
    
    var body: some View {
        VStack(spacing: getHeightPercent(5)) {
            Button(action: { }) {
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




