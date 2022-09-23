//
//  NumberItemFactory.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 9/23/22.
//

import Foundation

enum NumberItemFactory {
    static func makeNumberList(_ mode: GameMode) -> [NumberItem] {
        var count = 0
        var list: [NumberItem] = []
        
        while count < 4 {
            list.append(makeNumberItem(mode))
            count += 1
        }
        
        return list
    }
}

private extension NumberItemFactory {
    static func makeNumberItem(_ mode: GameMode) -> NumberItem {
        let number = Int.random(in: 0...9)
        let correctAnswer = getAnswer(for: number, mode: mode)
        
        return NumberItem(number: number, answer: correctAnswer)
    }
    
    static func getAnswer(for number: Int, mode: GameMode) -> Int {
        switch mode {
        case .add:
            let answer = number + 3
            
            return answer > 9 ? answer - 10 : answer
        }
    }
}
