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
    private var results: LevelResults? { dataModel.results }
    
    var body: some View {
        VStack {
            Spacer()
            NumberListView(list: dataModel.numberList)
            Spacer()
            VStack {
                if let results = results {
                    FinishedBanner(message: FinishedBannerMessageFactory.makeMessage(results))
                        .transition(.move(edge: .leading))
                    
                        Spacer()
                } else {
                    VStack(spacing: 0) {
                        TimerView(isActive: $dataModel.timerActive, timeRemaining: dataModel.startTime)
                        NumberPadView(selection: dataModel.submitNumber(_:))
                            .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(50))
                    }
                }
            }
            .animation(.linear, value: results)
            .overlay(PlayViewFooter(score: score, highScore: highScore, level: dataModel.level), alignment: .bottomLeading)
            
            
        }.onAppear { dataModel.startLevel() }
    }
}

// MARK: - Timer
fileprivate struct TimerView: View {
    @Binding var isActive: Bool
    @State var timeRemaining: Float
    
    private var startTime: Float
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private var timerText: String { String(format: "%.2f", timeRemaining) }
    private var timerColor: Color {
        let percentageRemaining = timeRemaining / startTime
        
        if percentageRemaining > 0.6 { return .primary }
        if percentageRemaining < 0.25 { return .red }
        
        return .yellow
    }
    
    init(isActive: Binding<Bool>, timeRemaining: Float) {
        _isActive = isActive
        self.timeRemaining = timeRemaining
        self.startTime = timeRemaining
    }
    
    var body: some View {
        Text(timerText)
            .padding(10)
            .opacity(isActive ? 1 : 0)
            .setSmoothFont(.headline, textColor: timerColor)
            .padding(.horizontal, isPad ? getWidthPercent(5) : 0)
            .onReceive(timer) { _ in
                guard isActive else { return }
                
                if timeRemaining > 0 {
                    timeRemaining -= 0.05
                } else {
                    isActive = false
                }
            }
    }
}


// MARK: - Footer
fileprivate struct PlayViewFooter: View {
    let score: Int
    let highScore: Int
    let level: Int
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Score: \(score)")
                Text("High Score: \(highScore)")
            }
            Spacer()
            Text("Level: \(level)")
        }.setChalkFont(.body)
        
    }
}


// MARK: - FinishedBanner
fileprivate struct FinishedBanner: View {
    let message: String?
    
    private var showMessage: Bool { message != nil }
    
    var body: some View {
        Text(message ?? "")
            .setChalkFont(.title)
            .opacity(message != nil ? 1 : 0)
            .animation(.default, value: showMessage)
    }
}


// MARK: - Preview
struct PlayView_Previews: PreviewProvider {
    static var info: LevelInfo { LevelInfo(score: 0, level: 1, highScore: 0) }
    static var updater: ScoreUpdater { ScoreManager(highScoreStore: SinglePlayHighScoreStore(), levelScoreStore: LevelScoreRepository()) }
    static var dataModel: PlayViewDataModel { PlayViewDataModel(numberList: NumberItem.defaultAddList, info: info, updater: updater, showResults: { _ in }) }
    
    static var previews: some View {
        PlayView(dataModel: dataModel)
            .onChalkboard()
            .preferredColorScheme(.dark)
    }
}
