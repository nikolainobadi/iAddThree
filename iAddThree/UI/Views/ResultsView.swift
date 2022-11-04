//
//  ResultsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/3/22.
//

import SwiftUI

struct ResultsView: View {
    @StateObject var dataModel: ResultsDataModel
    
    private var showingViews: Bool { dataModel.showingViews }
    private var completedLevel: Bool { dataModel.completedLevel }
    
    private func animateView() async {
        try? await Task.sleep(nanoseconds: 0_500_000_000)
        withAnimation(.linear(duration: completedLevel ? 1 : 2)) { dataModel.showResults() }
    }
    
    private func animateScore(_ newScore: Int?) {
        if let newScore = newScore {
            withAnimation(.linear(duration: 2)) { dataModel.currentScore = newScore }
        }
    }
    
    var body: some View {
        VStack {
            Text("Level \(dataModel.currentLevel) Results")
                .setChalkFont(.title3)
                .padding()
            
            VStack {
                if completedLevel {
                    ScoreCircle(currentScore: dataModel.currentScore)
                } else {
                    GameOverView()
                }
            }.opacity(showingViews ? 1 : 0)
            
            ChalkButton(dataModel.playAgainText, action: dataModel.playAgain)
                .opacity(dataModel.showingButton ? 1 : 0)
                .transition(.slide)
        }
        .task { await animateView() }
        .onChange(of: dataModel.newScore, perform: { animateScore($0) })
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
}

// MARK: - ScoreCircle
fileprivate struct ScoreCircle: View {
    let currentScore: Int
    
    var body: some View {
        Circle()
            .fill(Color.black)
            .opacity(0.6)
            .frame(width: getWidthPercent(40), height: getWidthPercent(40))
            .padding(getWidthPercent(20))
            .modifier(
                NumberAnimationModifier(number: currentScore)
                    .animation(.linear(duration: 1.5))
            )
    }
}

fileprivate struct GameOverView: View {
    var body: some View {
        Text("Game Over")
            .frame(maxWidth: getWidthPercent(95))
            .setChalkFont(.title3, textColor: .red)
            .background(.black.opacity(9))
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, getHeightPercent(5))
            .padding(.bottom, getHeightPercent(30))
            .transition(.move(edge: .bottom))
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
        content.overlay(Text("\(number)").setChalkFont(.largeTitle))
    }
}


// MARK: - Preview
struct ResultsView_Previews: PreviewProvider {
    static func makeResults(pointsToAdd: Int = 4, timerFinished: Bool = false) -> LevelResults {
        LevelResults(currentScore: 0, pointsToAdd: pointsToAdd, currentLevel: 1, timerFinished: timerFinished)
    }
    
    static var previews: some View {
        ResultsView(dataModel: ResultsDataModel(results: makeResults(pointsToAdd: 4), playAgain: { }))
            .onChalkboard()
    }
}
