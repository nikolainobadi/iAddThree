//
//  TextBackgroundViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct TextBackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(.black.opacity(0.5))
            .cornerRadius(20)
    }
}

extension View {
    func withTextBackground() -> some View { modifier(TextBackgroundViewModifier())}
}
