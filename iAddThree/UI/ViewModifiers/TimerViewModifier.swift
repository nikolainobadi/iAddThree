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
    
    let finished: () -> Void
    
    private let timer = Timer.publish(every: 0.05, on: .main, in: .common).autoconnect()
    private var timerText: String { String(format: "%.2f", timeRemaining) }
    
    func body(content: Content) -> some View {
        VStack {
            if isActive {
                Text(timerText)
            }
            content
        }.onReceive(timer) { _ in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 0.05
            } else {
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
