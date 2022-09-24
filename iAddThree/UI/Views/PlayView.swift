//
//  PlayView.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

struct PlayView: View {
    @StateObject var dataModel: PlayViewDataModel
    
    private func submitAnswer(_ number: String) {
        withAnimation {
            dataModel.submitAnswer(number)
        }
    }
    
    var body: some View {
        VStack {
            NumberListView(list: dataModel.numberList)
            NumberPadView(selection: submitAnswer(_:))
                .frame(maxWidth: getWidthPercent(90), maxHeight: getHeightPercent(55))
                .padding(.bottom)
        }
    }
}

struct PlayView_Previews: PreviewProvider {
    static var dataModel: PlayViewDataModel {
        PlayViewDataModel(numberList: NumberItemPresenter.defaultList, finished: { _ in })
    }
    
    static var previews: some View {
        PlayView(dataModel: dataModel).onChalkboard()
    }
}
