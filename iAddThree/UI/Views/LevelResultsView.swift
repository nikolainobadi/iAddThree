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
    
    let newScore: Int?
    let completedLevel: Int
    let playNextLevel: () -> Void
    
    private var gameOver: Bool { newScore == nil }
    private var size: CGFloat { getWidthPercent(40) }
    private var levelCompleteText: String { "Level \(completedLevel) \(gameOver ? "Results" : "Completed")" }
    
    var body: some View {
        VStack {
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
            
            ChalkButton("Next Level", action: playNextLevel)
                .opacity(showingButton ? 1 : 0)
            
            Spacer()
        }.task {
            if let newScore = newScore {
                try? await Task.sleep(nanoseconds: 1_000_000_000)

                withAnimation(.easeOut(duration: 1)) {
                    currentScore = newScore
                }

                try? await Task.sleep(nanoseconds: 0_500_000_000)
            }

            withAnimation(.easeInOut(duration: 1)) {
                showingButton = true
            }
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
        LevelResultsView(currentScore: 0, newScore: 4, completedLevel: 1, playNextLevel: { }).onChalkboard()
    }
}
