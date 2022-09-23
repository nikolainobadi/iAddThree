//
//  NumberItemPresenter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

struct NumberItemPresenter {
    private let item: NumberItem
    
    var userAnswer: String?
    var number: String { "\(item.number)" }
    var isCorrect: Bool { "\(item.answer)" == userAnswer }
    
    init(_ item: NumberItem) {
        self.item = item
    }
}
