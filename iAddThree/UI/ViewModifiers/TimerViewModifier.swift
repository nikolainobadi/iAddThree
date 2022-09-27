//
//  TimerViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/25/22.
//

import SwiftUI

struct TimerViewModifier: ViewModifier {
    @Binding var isActive: Bool
    @State var timeRemaining: Float
    private var startTime: Float
    
    let finished: () -> Void
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private var timerText: String { String(format: "%.2f", timeRemaining) }
    private var timerColor: Color {
        let percentageRemaining = timeRemaining / startTime
        
        if percentageRemaining > 0.6 { return .primary }
        if percentageRemaining < 0.25 { return .red }
        
        return .yellow
    }
    
    init(isActive: Binding<Bool>, timeRemaining: Float, finished: @escaping () -> Void) {
        _isActive = isActive
        self.timeRemaining = timeRemaining
        self.startTime = timeRemaining
        self.finished = finished
    }
    
    func body(content: Content) -> some View {
        VStack {
            if isActive {
                Text(timerText)
                    .setSmoothFont(.body, textColor: timerColor)
                    .padding(10)
            }
            content
        }.onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 0.05
            } else {
                isActive = false
                finished()
            }
        }
    }
}

extension View {
    func withTimer(isActive: Binding<Bool>, startTime: Float, finished: @escaping () -> Void) -> some View {
        modifier(TimerViewModifier(isActive: isActive, timeRemaining: startTime, finished: finished))
    }
}
