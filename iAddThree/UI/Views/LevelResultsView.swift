//
//  LevelResultsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct LevelResultsView: View {
    @State var currentScore: Int
    @State private var showingButton = false
    @State private var showingGameOver = false
    
    let newScore: Int?
    let completedLevel: Int
    let playNextLevel: () -> Void
    
    private var gameOver: Bool { newScore == nil }
    private var size: CGFloat { getWidthPercent(40) }
    private var levelCompleteText: String { "Level \(completedLevel) \(gameOver ? "Results" : "Completed")" }
    
    private func showNewScore(_ score: Int) async { withAnimation(.easeOut(duration: 1)) { currentScore = score } }
    private func showGameOver() async { withAnimation(.linear(duration: 2.5)) { showingGameOver = true } }
    private func showButton() async {
        try? await Task.sleep(nanoseconds: gameOver ? 2_000_000_000 : 0_500_000_000)
        withAnimation(.easeInOut(duration: 1)) { showingButton = true}
    }
    
    var body: some View {
        VStack {
            if gameOver {
                if showingGameOver {
                    Text("Game Over")
                        .frame(maxWidth: getWidthPercent(95))
                        .setChalkFont(.title3, textColor: .red)
                        .background(.black.opacity(9))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, getHeightPercent(5))
                        .padding(.bottom, getHeightPercent(30))
                        .transition(.move(edge: .bottom))
                }
            } else {
                Text(levelCompleteText)
                    .padding(.top, getHeightPercent(5))
                    .setChalkFont(.subheadline)
                Spacer()
                Circle()
                    .fill(Color.black)
                    .opacity(0.6)
                    .frame(width: size, height: size)
                    .modifier(NumberAnimationModifier(number: currentScore))
                    .padding(getWidthPercent(10))
            }
            
            ChalkButton("Next Level", action: playNextLevel)
                .opacity(showingButton ? 1 : 0)
                .transition(.slide)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            
            if let newScore = newScore {
                await showNewScore(newScore)
            } else {
                await showGameOver()
            }
            
           await showButton()
        }
    }
}


// MARK: - Animation
struct NumberAnimationModifier: AnimatableModifier {
    var number: Int
    
    var animatableData: Double {
        get { Double(number) }
        set { number = Int(newValue) }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(Text("\(number)").setChalkFont(.largeTitle))
    }
}


// MARK: - Preview
struct LevelResultsView_Previews: PreviewProvider {
    static var previews: some View {
        LevelResultsView(currentScore: 0, newScore: nil, completedLevel: 1, playNextLevel: { }).onChalkboard()
            .preferredColorScheme(.dark)
    }
}
