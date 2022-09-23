//
//  ChalkFontViewModifier.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct ChalkFontViewModifier: ViewModifier {
    let font: Font
    let textColor: Color
    let autoSize: Bool
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .foregroundColor(textColor)
            .minimumScaleFactor(autoSize ? 0.5 : 1)
    }
}

extension View {
    func setChalkFont(_ style: Font.TextStyle, textColor: Color = .white, autoSize: Bool = false) -> some View {
        modifier(ChalkFontViewModifier(font: makeChalkFont(style),textColor: textColor, autoSize: autoSize))
    }
    
    func setSmoothFont(_ style: Font.TextStyle, textColor: Color = .white, autoSize: Bool = false) -> some View {
        modifier(ChalkFontViewModifier(font: makeSmoothFont(style),textColor: textColor, autoSize: autoSize))
    }
    
    private func makeChalkFont(_ style: Font.TextStyle) -> Font { Font.custom("Chalkduster", size: makeFontSize(style)) }
    private func makeSmoothFont(_ style: Font.TextStyle) -> Font { Font.custom("Chalkboard SE Regular", size: makeFontSize(style)) }
    private func makeFontSize(_ style: Font.TextStyle) -> CGFloat {
        switch style {
        case .largeTitle: return getHeightPercent(isPad ? 8 : 7)
        case .title: return getHeightPercent(6)
        case .title2: return getHeightPercent(4.8)
        case .title3: return getHeightPercent(4)
        case .headline: return getHeightPercent(3.5)
        case .subheadline: return getHeightPercent(3)
        case .body: return getHeightPercent(2.5)
        default: return 8
        }
    }
}
