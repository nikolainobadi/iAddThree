//
//  View+Extensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/5/24.
//

import SwiftUI

func wait(seconds: Double) async {
    try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
}

func waitAndPerform(delay: Double, withAnimation animation: Animation? = nil, action: @escaping () -> Void) {
    Task {
        await wait(seconds: delay)
        
        if let animation = animation {
            withAnimation(animation) {
                action()
            }
        } else {
            action()
        }
    }
}
