//
//  DismissButton.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/18/22.
//

import SwiftUI

struct DismissButton: View {
    let dismiss: () -> Void
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: dismiss) {
                Image(systemName: "xmark")
                    .padding(.horizontal)
                    .setChalkFont(.subheadline)
            }
        }
    }
}
