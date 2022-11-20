//
//  Publisher+Extensions.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import Combine
import Foundation

extension Publisher {
    func dispatchOnMainQueue() -> AnyPublisher<Output, Failure> {
        receive(on: DispatchQueue.customScheduler).eraseToAnyPublisher()
    }
}
