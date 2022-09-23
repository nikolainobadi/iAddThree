//
//  NumberItemPresenter.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

struct NumberItemPresenter: Identifiable {
    private let item: NumberItem
    
    var id = UUID()
    var userAnswer: String?
    var number: String { "\(item.number)" }
    var isCorrect: Bool { "\(item.answer)" == userAnswer }
    
    init(_ item: NumberItem) {
        self.item = item
    }
}
