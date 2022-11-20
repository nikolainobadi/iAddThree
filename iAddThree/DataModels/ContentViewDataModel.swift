//
//  ContentViewDataModel.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/19/22.
//

import Foundation

final class ContentViewDataModel: ObservableObject {
    @Published var removeAds = false 
    
    init(publisher: ProStatusPublisher = ProStatusManager()) {
        publisher.removeAdsPublisher
            .dispatchOnMainQueue()
            .assign(to: &$removeAds)
    }
}


// MARK: - Dependencies
protocol ProStatusPublisher {
    var removeAdsPublisher: Published<Bool>.Publisher { get }
}
