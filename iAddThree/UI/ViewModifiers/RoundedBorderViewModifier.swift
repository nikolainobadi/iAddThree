//
//  RoundedBorderViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct RoundedBorderViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .padding(10)
            .background(Capsule(style: .continuous).fill(Color.primary.opacity(0.5)))
            .background(Capsule(style: .continuous).stroke(.white, lineWidth: 2))
    }
}

extension View {
    func withRoundedBorder() -> some View { modifier(RoundedBorderViewModifier())}
}
