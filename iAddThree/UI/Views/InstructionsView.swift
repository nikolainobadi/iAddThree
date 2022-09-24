//
//  InstructionsView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/24/22.
//

import SwiftUI

struct InstructionsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var dataModel: InstructionsDataModel
    
    var body: some View {
        VStack {
            
        }.onChalkboard()
    }
}

struct InstructionsView_Previews: PreviewProvider {
    static func makeDataModel() -> InstructionsDataModel {
        InstructionsDataModel()
    }
    
    static var previews: some View {
        InstructionsView(dataModel: makeDataModel())
    }
}

final class InstructionsDataModel: ObservableObject {
    
}
