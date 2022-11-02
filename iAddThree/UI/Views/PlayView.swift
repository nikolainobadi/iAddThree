//
//  PlayView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/1/22.
//

import SwiftUI

struct PlayView: View {
    @StateObject var dataModel: PlayViewDataModel
    
    private var score: Int { dataModel.score }
    private var highScore: Int { dataModel.highScore }
    private var showFinishedBanner: Bool { dataModel.results != nil }
    
    var body: some View {
        VStack {
            Text("Level: \(dataModel.level)")
                .setChalkFont(.body)
                .padding(5)
            
            NumberListView(list: dataModel.numberList)
            
            Spacer()
            
            FinishedBanner(message: "Nice")
                .opacity(showFinishedBanner ? 1 : 0)
                .animation(.default, value: showFinishedBanner)
            
            NumberPadView(selection: dataModel.submitNumber(_:))
                .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(55))
            
            Spacer()
        }.overlay(PlayViewFooter(score: score, highScore: highScore).padding(), alignment: .bottomLeading)
    }
}


// MARK: - Footer
fileprivate struct PlayViewFooter: View {
    let score: Int
    let highScore: Int
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(score)")
            Text("High Score: \(highScore)")
        }.setChalkFont(.body)
    }
}


// MARK: - FinishedBanner
fileprivate struct FinishedBanner: View {
    let message: String
    
    var body: some View {
        Text(message)
            .setChalkFont(.title)
    }
}


// MARK: - Preview
struct PlayView_Previews: PreviewProvider {
    static var store: GameStore { GameStorageManager(store: SinglePlayHighScoreStore())}
    static var previews: some View {
        PlayView(dataModel: PlayViewDataModel(numberList: NumberItem.defaultList, store: store, showResults: { _ in }))
            .onChalkboard()
            .preferredColorScheme(.dark)
    }
}
