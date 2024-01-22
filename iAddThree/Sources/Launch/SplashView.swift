//
//  SplashView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI
import NnSwiftUIKit

struct SplashView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack {
            TitleBanner(canShowSubtractBanner: false)
                .padding(.horizontal)
                .offset(y: isAnimating ? 0 : getHeightPercent(70))
                .animation(.easeInOut(duration: 1.5), value: isAnimating)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(.black.opacity(0.2))
        .animation(.smooth, value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}
