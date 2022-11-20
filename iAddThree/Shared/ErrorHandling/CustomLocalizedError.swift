//
//  CustomLocalizedError.swift
//  iAddThree
//
//  Created by Nikolai Nobadi on 11/20/22.
//

import Foundation

struct CustomLocalizedError: LocalizedError {
    private let underlyingError: CustomError
    
    var errorDescription: String? { underlyingError.title }
    var recoverySuggestion: String? { underlyingError.suggestion }
    var message: String { underlyingError.message }

    init?(error: Error?) {
        guard let localizedError = error as? CustomError else { return nil }
        
        underlyingError = localizedError
    }
}


// MARK: - Dependencies
protocol CustomError: Error {
    var title: String? { get }
    var message: String { get }
    var suggestion: String? { get }
}
