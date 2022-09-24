//
//  ChalkButton.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import SwiftUI

struct ChalkButton: View {
    let text: String
    let style: Font.TextStyle
    let action: () -> Void
    
    init(_ text: String, style: Font.TextStyle = .title3, action: @escaping () -> Void) {
        self.text = text
        self.style = style
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .padding(.horizontal, getWidthPercent(10))
                .lineLimit(1)
                .setChalkFont(style, textColor: Color(uiColor: .systemBackground), autoSize: true)
                .withRoundedBorder()
        }
    }
}
