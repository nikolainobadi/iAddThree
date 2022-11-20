//
//  MockUserDefaults.swift
//  iAddThreeTests
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import Foundation

class MockUserDefaults: UserDefaults {
    private var values = [String: Any]()
    
    override func object(forKey defaultName: String) -> Any? { values[defaultName] }
    override func set(_ value: Any?, forKey defaultName: String) { values[defaultName] = value }
}
