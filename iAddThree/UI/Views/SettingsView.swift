//
//  SettingsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/26/22.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel = SettingsDataModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Settings")
                .setChalkFont(.title)
            Text(dataModel.aboutText)
                .setSmoothFont(.body)
                .padding()
                .background(.black.opacity(0.5))
                .cornerRadius(20)
                .padding(5)
                .frame(maxHeight: getHeightPercent(60))
            
            Spacer()
            
            VStack {
                SettingsButtonView(emailURLString: dataModel.emailURL, rateApp: dataModel.requestAppReview)
                Link(destination: URL(string: dataModel.privacyPolicyURL)!) {
                    Text("Privacy Policy")
                        .underline()
                        .setSmoothFont(.body)
                }
            }.padding()
        }
        .onChalkboard()
        .overlay(
            Button(action: { dismiss() }, label: { Image(systemName: "xmark") })
                .setChalkFont(.subheadline)
                .padding(.horizontal)
            , alignment: .topTrailing
        )
    }
}


// MARK: - Buttons
fileprivate struct SettingsButtonView: View {
    let emailURLString: String
    let rateApp: () -> Void
    
    var body: some View {
        if isSmallDevice {
            HStack {
                Link("Feedback?", destination: URL(string: emailURLString)!)
                    .lineLimit(1)
                    .withRoundedBorder()
                    .padding()
               
                Button(action: rateApp) {
                    Text("Rate App")
                        .withRoundedBorder()
                        .padding()
                }
            }.setChalkFont(.subheadline, autoSize: true)
        } else {
            VStack {
                Link("Feedback?", destination: URL(string: emailURLString)!)
                    .frame(width: getWidthPercent(60))
                    .withRoundedBorder()
                    .padding()
                
                Button(action: rateApp) {
                    Text("Rate App")
                        .frame(width: getWidthPercent(60))
                        .withRoundedBorder()
                        .padding()
                }
            }.setChalkFont(.headline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
//        SettingsView()
//            .previewDevice("iPod touch (7th generation)")
//        SettingsView()
//            .previewDevice("iPhone 8")
//        SettingsView()
//            .previewDevice("iPhone 11")
//        SettingsView()
        SettingsView()
            .previewDevice("iPad mini (6th generation)")
        SettingsView()
            .previewDevice("iPad (9th generation)")
        SettingsView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
    }
}




