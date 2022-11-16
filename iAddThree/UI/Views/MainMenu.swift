//
//  MainMenu.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/14/22.
//

import SwiftUI

struct MainMenu: View {
    @State private var selectedMode: GameMode?
    @StateObject private var dataModel = MainMenuDataModel()
    @AppStorage(AppStorageKey.modeLevel) var modeLevel: Int = 1
    
    private var availableModes: [GameMode] { dataModel.availableModes }
    private func playMode(_ mode: GameMode) { selectedMode = mode }
    private func returnToMainMenu() { selectedMode = nil }
    
    var body: some View {
        VStack {
            AppTitleView(modeLevel: modeLevel)
            Spacer()
            ModeButtonsView(modes: availableModes, playMode: playMode(_:))
            Spacer()
        }
        .onChange(of: modeLevel, perform: { dataModel.updateModeLevel($0) })
        .fullScreenCover(item: $selectedMode) {
            GameView(mode: $0, dismiss: returnToMainMenu).onChalkboard()
        }
    }
}


// MARK: - Title
fileprivate struct AppTitleView: View {
    @State private var showingSubtractBanner = false
    
    let modeLevel: Int
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("i")
                Text("Add").foregroundColor(.green)
                Text("Three")
            }
            .lineLimit(1)
            .setChalkFont(.largeTitle, autoSize: true)
            .padding(.horizontal)
            
            if showingSubtractBanner {
                HStack {
                    Text("or Subtract")
                        .setChalkFont(.body, textColor: .red)
                        .padding(.horizontal)
                    Spacer()
                }
                    .background(Color.black.opacity(0.4))
                    .offset(x: 0, y: -getHeightPercent(1))
                    .transition(.move(edge: .leading))
            }
        }.task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            if modeLevel > 1 {
                withAnimation(.easeInOut(duration: 1)) {
                    showingSubtractBanner = true
                }
            }
        }
    }
}


// MARK: - ModeButtonsList
fileprivate struct ModeButtonsView: View {
    let modes: [GameMode]
    let playMode: (GameMode) -> Void
    
    var body: some View {
        VStack {
            ForEach(modes, id: \.self) { mode in
                ChalkButton(mode.title, action: { playMode(mode) })
            }
        }
    }
}


// MARK: - Preview
struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu()
            .onChalkboard()
    }
}
