//
//  NnSwiftUIKit+ViewExtensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/24/24.
//

import SwiftUI
import NnSwiftUIKit

public extension View {
    func getWidthPercent(_ percent: CGFloat) -> CGFloat {
        return nnGetWidthPercent(percent)
    }
    
    func getHeightPercent(_ percent: CGFloat) -> CGFloat {
        return nnGetHeightPercent(percent)
    }
}

// MARK: - Error Handling
public extension View {
    func withErrorHandling() -> some View {
        self
            .nnWithNnLoadingView()
            .nnWithNnErrorHandling()
    }
    
//    func nnSheetWithErrorHandling<Item: Identifiable, Sheet: View>(item: Binding<Item?>, isDisabled: Bool = false, @ViewBuilder sheet: @escaping (Item) -> Sheet) -> some View {
//        modifier(ItemSheetErrorHandlingViewModifier(item: item, isDisabled: isDisabled, sheet: sheet))
//    }
//    
    func sheetWithErrorHandling<Sheet: View>(isPresented: Binding<Bool>, @ViewBuilder sheet: @escaping () -> Sheet) -> some View {
        self.nnSheetWithErrorHandling(isPresented: isPresented, sheet: sheet)
    }
//    
//    func nnAsyncOnChange<Item: Equatable>(of item: Item?, hideLoadingIndicator: Bool = false, action: @escaping (Item) async throws -> Void) -> some View {
//        modifier(AsyncOnChangeOfOptionalViewModifier(item: item, hideLoadingIndicator: hideLoadingIndicator, action: action))
//    }
//    
//    func nnAsyncHandleURL(hideLoadingIndicator: Bool = false, asyncAction: @escaping (URL) async throws -> Void) -> some View {
//        modifier(AsyncOpenURLViewModifier(hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction))
//    }
//    
    func asyncTask(delay: Double = 0, hideLoadingIndicator: Bool = false, asyncAction: @escaping () async throws -> Void) -> some View {
        self.nnAsyncTask(delay: delay, hideLoadingIndicator: hideLoadingIndicator, asyncAction: asyncAction)
    }
//    
//    func nnAsyncTapGesture(asRowItem: NnAsyncTapRowItem? = nil, action: @escaping () async throws -> Void) -> some View {
//        modifier(AsyncTryTapGestureViewModifier(asRowItem: asRowItem, action: action))
//    }
}

// MARK: - iOS 15+ Error Handling
public extension View {
//    func nnAsyncConfirmation(showingConfirmation: Binding<Bool>, role: ButtonRole? = nil, buttonText: String, message: String, action: @escaping () async throws -> Void) -> some View {
//        modifier(AsyncConfirmationDialogueViewModifier(showingConfirmation: showingConfirmation, role: role, buttonText: buttonText, message: message, action: action))
//    }
//    
//    func nnWithSwipeDelete(message: String = "Are you sure you want to delete this item?", isActive: Bool = true, delete: @escaping () async throws -> Void) -> some View {
//        modifier(DeleteRowViewModifier(message: message, isActive: isActive, delete: delete))
//    }
}


// MARK: - Conditionals
public extension View {
    func onlyShow(when conditional: Bool) -> some View {
        self.nnOnlyShow(when: conditional)
    }
    
//    func nnWithBorderOverlay(_ showOverlay: Bool, color: Color = .red, cornerRadius: CGFloat = 10) -> some View {
//        modifier(ConditionalBorderOverlayViewModifier(color: color, showOverlay: showOverlay, cornerRadius: cornerRadius))
//    }
//    
//    func nnWithNavTitle(title: String?) -> some View {
//        modifier(ConditionalNavTitleViewModifier(title:

//    func nnAsNavLink<D: Hashable>(_ data: D, isActive: Bool = true) -> some View {
//        modifier(ConditionalNavigationLinkViewModifier(data: data, isActive: isActive))
//    }
}


// MARK: - Designs
public extension View {
//    func nnAsRowItem(withChevron: Bool = false) -> some View {
//        modifier(RowItemViewModifier(withChevron: withChevron))
//    }
//    
//    func setCustomFont(_ style: Font.TextStyle, fontName: String, isSmooth: Bool = false, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
//        modifier(CustomFontViewModifier(font: makeFont(style, fontName: fontName), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
//    }
//    
//    func setCustomFont(fontName: String, size: CGFloat, textColor: Color = .primary, autoSize: Bool = false, minimumScaleFactor: CGFloat = 0.5) -> some View {
//        modifier(CustomFontViewModifier(font: Font.custom(fontName, size: size), textColor: textColor, autoSize: autoSize, minimumScaleFactor: minimumScaleFactor))
//    }
//    
    func framePercent(widthPercent: CGFloat, heighPercent: CGFloat, alignment: Alignment = .center) -> some View {
        self.nnFramePercent(widthPercent: widthPercent, heighPercent: heighPercent, alignment: alignment)
    }
}


// MARK: - Navigation
public extension View {
//    func nnWithNavBarButton(placement: ToolbarItemPlacement = .navigationBarTrailing, buttonContent: NavBarButtonContent, font: Font = .title2, textColor: Color = .primary, action: @escaping () -> Void) -> some View {
//        modifier(NavBarButtonViewModifier(placement: placement, buttonContent: buttonContent, font: font, textColor: textColor, action: action))
//    }
}


// MARK: - iOS 15+ Navigation
public extension View {
//    func nnWithNavBarDismissButton(isActive: Bool = true, dismissType: NavBarDismissType = .xmark, dismiss: (() -> Void)? = nil) -> some View {
//        modifier(NavBarDismissButtonViewModifier(isActive: isActive, dismissType: dismissType, action: dismiss))
//    }
}


// MARK: - Utility
public extension View {
    func delayedOnAppear(seconds: Double, perform action: @escaping () -> Void) -> some View {
        self.nnDelayedOnAppear(seconds: seconds, perform: action)
    }
    
//    func nnTappable(withChevron: Bool = false, onTapGesture: @escaping () -> Void) -> some View {
//        modifier(TappableRowViewModifier(withChevron: withChevron, onTapGesture: onTapGesture))
//    }
}

