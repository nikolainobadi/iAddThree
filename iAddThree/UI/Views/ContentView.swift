//
//  ContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var dataModel = ContentViewDataModel()
    
    private var showBanner: Bool { !dataModel.isPro }
    
    var body: some View {
        VStack {
            MainMenu()
            
            if showBanner {
                Spacer()
                AdMobComposer.makeAdBannerView()
                    .padding(.bottom, 10)
            }
        }.onChalkboard()
    }
}

// MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
