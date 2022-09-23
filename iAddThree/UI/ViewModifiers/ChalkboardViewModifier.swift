//
//  ChalkboardViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct ChalkboardViewModifier: ViewModifier {
    private let chalkboard = "chalkboard"
    
    func body(content: Content) -> some View {
        ZStack {
            Image(chalkboard)
                .resizable()
                .ignoresSafeArea()
            
            content
        }
    }
}

extension View {
    func onChalkboard() -> some View { modifier(ChalkboardViewModifier()) }
}
