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
    
    var body: some View {
        VStack {
            Text("Level: \(dataModel.level)")
                .setChalkFont(.body)
                .padding()
            
            NumberListView(list: dataModel.numberList).padding()
            FinishedBanner(message: dataModel.finishedMessage)
            NumberPadView(selection: dataModel.submitNumber(_:))
                .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(55))
        }
        .onAppear { dataModel.startLevel() }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .overlay(TimerView(isActive: $dataModel.timerActive, timeRemaining: dataModel.startTime), alignment: .topTrailing)
        .overlay(PlayViewFooter(score: score, highScore: highScore).padding(), alignment: .bottomLeading)
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
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Score: \(score)")
            Text("High Score: \(highScore)")
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
    static var store: GameStore { GameStorageManager(store: SinglePlayHighScoreStore())}
    static var previews: some View {
        PlayView(dataModel: PlayViewDataModel(numberList: NumberItem.defaultList, store: store, showResults: { _ in }))
            .onChalkboard()
            .preferredColorScheme(.dark)
    }
}
