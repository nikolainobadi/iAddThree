//
//  View+Extension.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

extension View {
    var isPad: Bool { UIDevice.current.userInterfaceIdiom == .pad }
    var isSmallDevice: Bool { screenHeight < 600 }
    var screenWidth: CGFloat { UIScreen.main.bounds.size.width }
    var screenHeight: CGFloat { UIScreen.main.bounds.size.height }
    
    /// Percent required in parameter is direct representation. Example: 1% of width = getWidthPercent(1). 10% of width = getWidthPercent(10)
    func getWidthPercent(_ percent: CGFloat) -> CGFloat { screenWidth * (percent * 0.01) }
    
    /// Percent required in parameter is direct representation. Example: 1% of height = getHeightPercent(1). 10% of height = getHeightPercent(10)
    func getHeightPercent(_ percent: CGFloat) -> CGFloat { screenHeight * (percent * 0.01) }
    
    func canShowError(error: Binding<Error?>, buttonTitle: String = "OK", doneAction: (() -> Void)? = nil) -> some View {
        let localizedAlertError = CustomLocalizedError(error: error.wrappedValue)
        
        return alert(isPresented: .constant(localizedAlertError != nil), error: localizedAlertError) { _ in
            Button(action: { doneAction?() }) {
                Text("Okay")
            }
        } message: { error in
            Text(error.message)
        }
    }
}
