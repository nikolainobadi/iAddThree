//
//  MainMenu.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/14/22.
//

import SwiftUI

struct MainMenu: View {
    @State private var selectedMode: GameMode?
    @AppStorage(AppStorageKey.modeLevel) var modeLevel: Int = 0

    private func playMode(_ mode: GameMode) { selectedMode = mode }
    private func returnToMainMenu() { selectedMode = nil }
    
    var body: some View {
        VStack {
            if let selectedMode = selectedMode {
                GameView(mode: selectedMode, dismiss: returnToMainMenu)
                    .onChalkboard()
                    .transition(.move(edge: .bottom))
            } else {
                VStack {
                    AppTitleView(modeLevel: modeLevel)
                    Spacer()
                    ModeButtonsView(modeLevel: modeLevel, playMode: playMode(_:))
                    Spacer()
                }
            }
        }.animation(.default, value: selectedMode)
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
    let modeLevel: Int
    let playMode: (GameMode) -> Void
    
    var body: some View {
        VStack {
            ModeButton("Add", action: { playMode(.add) })
            ModeButton("Subtract", action: { playMode(.subtract) })
                .opacity(modeLevel >= 1 ? 1 : 0)
        }
    }
}


// MARK: - Button
fileprivate struct ModeButton: View {
    let text: String
    let style: Font.TextStyle
    let action: () -> Void
    
    init(_ text: String, style: Font.TextStyle = .title3, action: @escaping () -> Void) {
        self.text = text
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .lineLimit(1)
                .setChalkFont(style, textColor: Color(uiColor: .systemBackground), autoSize: true)
                .frame(maxWidth: getWidthPercent(isPad ? 50 : 70))
                .withRoundedBorder()
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
