//
//  GameViewComposer.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import SwiftUI

enum GameViewComposer {
    static func makePlayView(_ mode: GameMode, finished: @escaping (Int) -> Void) -> some View {
        PlayView(dataModel: PlayViewDataModel(numberList: makeItemPresenterList(mode), finished: finished))
    }
}


//  MARK: - Private Methods
private extension GameViewComposer {
    static func makeItemPresenterList(_ mode: GameMode) -> [NumberItemPresenter] {
        NumberItemFactory.makeNumberList(mode).map({ NumberItemPresenter($0) })
    }
}
