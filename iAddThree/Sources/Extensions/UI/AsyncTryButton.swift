//
//  AsyncTryButton.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/24/24.
//

import SwiftUI
import NnSwiftUIKit

public struct TryButton<Label>: View where Label: View {
    @ViewBuilder var label: () -> Label
    @EnvironmentObject var errorHandler: NnSwiftUIErrorHandler
    
    let role: NnButtonRole?
    let action: () throws -> Void

    public var body: some View {
        NnTryButton(action: action, role: role, label: label)
    }
}

public extension TryButton where Label == Text {
    init<S>(_ title: S, role: NnButtonRole? = nil, action: @escaping () throws -> Void) where S: StringProtocol {
        self.init(label: { Text(title) }, role: role, action: action)
    }
}


// MARK: - AsyncTryButton
public struct AsyncTryButton<Label>: View where Label: View {
    @ViewBuilder var label: () -> Label
    
    let role: NnButtonRole?
    let action: () async throws -> Void
    
    public init(action: @escaping () async throws -> Void, role: NnButtonRole? = nil, label: @escaping () -> Label) {
        self.action = action
        self.label = label
        self.role = role
    }
    
    public var body: some View {
        NnAsyncTryButton(action: action, role: role, label: label)
    }
}
