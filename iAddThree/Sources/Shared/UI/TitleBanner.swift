//
//  TitleBanner.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI
import NnSwiftUIHelpers
import iAddThreeClassicKit

struct TitleBanner: View {
    @State private var showingSubtractBanner = false
    
    let canShowSubtractBanner: Bool
    
    private func startAnimation() {
        if canShowSubtractBanner {
            showingSubtractBanner = true
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("i")
                Text("Add")
                    .foregroundColor(.green)
                Text("Three")
            }
            .lineLimit(1)
            .setChalkFont(.largeTitle, autoSize: true)
            .padding(.horizontal)
            
            HStack {
                Text("or Subtract")
                    .setChalkFont(.body, textColor: .red)
                    .padding(.horizontal)
                Spacer()
            }
            .background(Color.black.opacity(0.4))
            .offset(x: 0, y: -getHeightPercent(1))
            .transition(.move(edge: .leading))
            .onlyShow(when: showingSubtractBanner)
        }
        .animation(.easeIn(duration: 1), value: showingSubtractBanner)
        .delayedOnAppear(seconds: 1) {
            startAnimation()
        }
    }
}
