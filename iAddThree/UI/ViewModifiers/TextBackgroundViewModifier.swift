//
//  TextBackgroundViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct TextBackgroundViewModifier: ViewModifier {
    let opacity: CGFloat
    func body(content: Content) -> some View {
        content
            .background(.black.opacity(opacity))
            .cornerRadius(20)
    }
}

extension View {
    func withTextBackground(opacity: CGFloat = 0.5) -> some View { modifier(TextBackgroundViewModifier(opacity: opacity)) }
}
