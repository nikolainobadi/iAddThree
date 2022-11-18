//
//  ContentView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            MainMenu()
            Spacer()
            AdMobComposer.makeAdBannerView()
                .background(.black)
                .padding(.bottom, 10)
        }.onChalkboard()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPod touch (7th generation)")
    }
}
