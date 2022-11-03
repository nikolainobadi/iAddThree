//
//  LevelResultsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct LevelResultsView: View {
    @State private var showingButton = false
    @StateObject var dataModel: LevelResultsDataModel
    
    private var completedLevel: Bool { dataModel.completedLevel }
    private var showingGameOver: Bool { dataModel.showingGameOver }
    
    private func playNextLevel() { dataModel.playNextLevel() }
    private func animateResults() async {
        try? await Task.sleep(nanoseconds: 1_000_000_000)
        withAnimation(.linear(duration: completedLevel ? 1.5 : 2)) { dataModel.updateScore() }
        try? await Task.sleep(nanoseconds: completedLevel ? 0_500_000_000 : 2_000_000_000)
        withAnimation(.easeInOut(duration: 1)) { showingButton = true }
    }
    
    var body: some View {
        VStack {
            if completedLevel {
                Text(dataModel.titleText)
                    .padding(.top, getHeightPercent(5))
                    .setChalkFont(.subheadline)
                Circle()
                    .fill(Color.black)
                    .opacity(0.6)
                    .frame(width: getWidthPercent(40), height: getWidthPercent(40))
                    .modifier(NumberAnimationModifier(number: dataModel.currentScore))
                    .padding(getWidthPercent(20))
            } else {
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
            }
            
            ChalkButton(dataModel.playAgainText, action: playNextLevel)
                .opacity(showingButton ? 1 : 0)
                .transition(.slide)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .task { await animateResults() }
    }
}





// MARK: - Preview
struct LevelResultsView_Previews: PreviewProvider {
    static func makeDataModel(newScore: Int? = nil) -> LevelResultsDataModel {
        LevelResultsDataModel(currentScore: 0, newScore: 4, previousLevel: 1, playNextLevel: { })
    }
    static var previews: some View {
        LevelResultsView(dataModel: makeDataModel()).onChalkboard()
    }
}


