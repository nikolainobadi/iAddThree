//
//  ContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = ContentViewDataModel()
    @AppStorage(AppStorageKey.adsRemoved) var removeAds: Bool = false
    
    var body: some View {
        VStack {
            MainMenu()
            
            if !removeAds {
                Spacer()
                AdMobComposer.makeAdBannerView()
                    .padding(.bottom, 10)
            }
        }
        .onChalkboard()
        .onChange(of: dataModel.removeAds, perform: { newValue in
            removeAds = newValue
        })
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
