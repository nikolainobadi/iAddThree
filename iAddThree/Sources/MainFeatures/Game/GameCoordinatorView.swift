//
//  GameCoordinatorView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 1/2/24.
//

import SwiftUI

struct GameCoordinatorView: View {
    @State private var selectedMode: String?
    
    var body: some View {
        if let selectedMode = selectedMode {
            Text("play \(selectedMode)")
        } else {
            Text("Game Menu")
        }
    }
}


// MARK: - Preview
#Preview {
    GameCoordinatorView()
}
