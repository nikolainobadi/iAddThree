//
//  PlayView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct PlayView: View {
    @StateObject var dataModel: PlayViewDataModel
    
    var body: some View {
        VStack {
            NumberListView(list: dataModel.numberList)
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var dataModel: PlayViewDataModel {
        PlayViewDataModel(numberList: [], finished: { _ in })
    }
    
    static var previews: some View {
        PlayView(dataModel: dataModel)
    }
}
