//
//  ContentViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import Foundation

final class ContentViewDataModel: ObservableObject {
    @Published var isPro = false
    
    init(publisher: ProStatusPublisher = ProStatusManager()) {
        publisher.isProPublisher
            .dispatchOnMainQueue()
            .assign(to: &$isPro)
    }
}


// MARK: - Dependencies
protocol ProStatusPublisher {
    var isProPublisher: Published<Bool>.Publisher { get }
}
